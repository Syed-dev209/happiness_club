import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/widgets/dealCard.dart';
import 'package:happiness_club/modules/home/widgets/deal_shimmer_card.dart';
import 'package:happiness_club/modules/nearby/nearby_controller.dart';
import 'package:happiness_club/modules/nearby/widget/nearby_deal_card.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/modules/offers/Screens/offerDetailsScreen.dart';
import 'package:happiness_club/modules/offers/Widget/offer_card_shimmer.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/constants/fontStyles.dart';
import 'package:happiness_club/widgets/snackBars.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  _NearbyScreenState createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> with AutomaticKeepAliveClientMixin {
  bool keepAlive = false;
  GoogleMapController? mapController;
  List<Marker> markers =[];
  BitmapDescriptor? customIcon;
  LatLng currentPosition=LatLng(37.43296265331129, -122.08832357078792);
  StreamController<OffersModel?>? offerController;
  getCurrentLocation()async{
    LatLng pos = await LocationService().getCurrentLocation();
    print(pos.latitude);
    print(pos.longitude);
    setState(() {
      currentPosition = pos;
    });
  }

  ScrollController? scrollController;
  int start=0, end=9;
  bool loading = false;
  double mapLoading = 0.0;
  bool released = false;
  _scrollListener() {
    if (scrollController!.offset >= scrollController!.position.maxScrollExtent &&
        !scrollController!.position.outOfRange) {
      setState(() {
        loading = true;
      });
      loadData();
      // setState(() {
      //   message = "reach the bottom";
      // });
    }
    if (scrollController!.offset <= scrollController!.position.minScrollExtent &&
        !scrollController!.position.outOfRange) {
      // setState(() {
      //   message = "reach the top";
      // });
    }
  }

  loadData()async{
    await getCurrentLocation();
    getNearbyOffers(currentPosition,start,end).then((value) {
      start = start +10;
      end = end + 10;
      setState(() {
        loading = false;
        released = true;
      });
      if(value!=null){
        offerController!.add(value);
        return value;
      }
      else{
        offerController!.add(null);
        return null;
      }
    });
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offerController = StreamController<OffersModel?>();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(8, 8)),
        Images.NEARBY_MARKER)
        .then((d) {
          setState(() {
            customIcon = d;
          });
    });
    scrollController = ScrollController();
    scrollController!.addListener(_scrollListener);
    loadData();
    keepAlive = true;
    updateKeepAlive();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    markers.add(Marker(
        markerId: MarkerId("1"),
        icon: BitmapDescriptor.defaultMarker,
        position: currentPosition
    ));
    return RefreshIndicator(
      onRefresh: ()async{
        loadData();
      },
      child: SingleChildScrollView(
        child: Container(
          height: size.height*0.895,
          width: size.width,
          child: StreamBuilder<OffersModel?>(
            stream: offerController!.stream,
            builder: (context,snapshot){
              if(!snapshot.hasData || snapshot.hasError || snapshot.connectionState== ConnectionState.waiting){
                return  Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 220,
                    width: double.maxFinite,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,i){
                          return DealShimmerCard(smallCard: true);
                        },
                        separatorBuilder: (context,i)=>SizedBox(width: 12,),
                        itemCount: 4
                    ),
                  ),
                );
              }
              if(snapshot.data == null || snapshot.data!.data!.isEmpty){
                return Center(child: noDataFound());
              }
              List<OffersModelData?> dataList= [];
              dataList.addAll(snapshot.data!.data!);
              // for(var i in dataList){
              //   if(i!.longitude!=null && i.latitude!=null){
              //     double lat = double.parse(i.latitude??"0.0");
              //     double long = double.parse(i.longitude??"0.0");
              //     markers.add(Marker(
              //       markerId: MarkerId("${i.id}"),
              //       icon: customIcon!,
              //       position: LatLng(lat,long),
              //       infoWindow: InfoWindow(
              //         title: "${i.title}",
              //         snippet: "${i.categoryName}",
              //         onTap: (){
              //           Navigator.push(context, CupertinoPageRoute(builder: (_)=>OfferDetailsScreen(offerId: i.id!.toString(),)));
              //         }
              //       )
              //     ));
              //   }
              // }
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          onCameraIdle: ()async{
                            if(released) {
                              //showLoader();
                              setState(() {
                                mapLoading = 50;
                              });
                              LatLngBounds bounds = await mapController!
                                  .getVisibleRegion();
                              double zoomLevel = await mapController!
                                  .getZoomLevel();
                              LatLng center = LatLng(
                                  (bounds.northeast.latitude +
                                      bounds.southwest.latitude) / 2,
                                  (bounds.northeast.longitude +
                                      bounds.southwest.longitude) / 2
                              );
                              print("On idle $center");
                              getMapNearbyOffers(context, center, zoomLevel).then((
                                  value) {
                                //Navigator.maybePop(context);
                                if (value != null) {
                                  for (var data in value.data!) {
                                    if (data!.longitude != null &&
                                        data.longitude != null) {
                                      double lat = double.parse(
                                          data.latitude ?? "0.0");
                                      double long = double.parse(
                                          data.longitude ?? "0.0");
                                      markers.add(Marker(
                                          markerId: MarkerId("${data.id}"),
                                          icon: customIcon!,
                                          position: LatLng(lat, long),
                                          infoWindow: InfoWindow(
                                              title: "${data.title}",
                                              snippet: "${data.categoryName}",
                                              onTap: () {
                                                Navigator.push(context,
                                                    CupertinoPageRoute(
                                                        builder: (_) =>
                                                            OfferDetailsScreen(
                                                              offerId: data.id!
                                                                  .toString(),)));
                                              }
                                          )
                                      ));
                                    }
                                  }
                                  setState(() {
                                    mapLoading = 0.0;
                                  });
                                }
                              });
                            }
                          },
                          // onCameraMove: (pos){
                          //   print(pos.target.latitude);
                          //   print(pos.target.longitude);
                          // },
                            buildingsEnabled: true,
                            indoorViewEnabled: true,
                            mapType: MapType.normal,
                            zoomControlsEnabled: true,
                            myLocationButtonEnabled: false,
                            compassEnabled: false,
                            markers: markers.toSet(),
                            onMapCreated: (controller){
                              mapController = controller;
                              double mid = dataList.length/2;
                              double lat = double.parse(dataList[mid.floor()]!.latitude!);
                              double long = double.parse(dataList[mid.floor()]!.longitude!);
                              mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentPosition.latitude,currentPosition.longitude),zoom: 15)));
                            },
                            initialCameraPosition: CameraPosition(bearing: 192.8334901395799, target: currentPosition, zoom: 12,tilt: 4)
                        ),
                        Positioned(
                       top: 50,
                          right: 5,
                          left: 5,
                          child: AnimatedContainer(
                            curve: Curves.bounceInOut,
                            duration: Duration(milliseconds: 500),
                            height: mapLoading,
                            width: mapLoading,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0,1),
                                  color: Colors.black26,
                                  blurRadius: 1,
                                  spreadRadius: 1
                                )
                              ]
                            ),
                            child: Center(
                              child: getLoader(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 170,
                            width: double.maxFinite,
                            child: ListView.separated(
                              controller: scrollController,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              scrollDirection: Axis.horizontal,
                                itemBuilder: (context,i){
                                  return NearbyDealCard(
                                      width: 161,
                                      modelData: dataList[i]!,
                                      type: StorageKeys.FEATURED_OFFERS,
                                    onTap: (String lat, String long){
                                        setState(() {
                                          released = false;
                                        });
                                        final markerId = MarkerId("${dataList[i]!.id}");
                                        markers.add(Marker(
                                            markerId: markerId,
                                            icon: customIcon!,
                                            position: LatLng(double.parse(lat), double.parse(long)),
                                            infoWindow: InfoWindow(
                                                title: "${dataList[i]!.title}",
                                                snippet: "${dataList[i]!.categoryName}",
                                                onTap: () {
                                                  Navigator.push(context,
                                                      CupertinoPageRoute(
                                                          builder: (_) =>
                                                              OfferDetailsScreen(
                                                                offerId: dataList[i]!.id!
                                                                    .toString(),)));
                                                }
                                            )
                                        ));
                                      mapController!.animateCamera(CameraUpdate.newCameraPosition(
                                          CameraPosition(target: LatLng(double.parse(lat),double.parse(long)),zoom: 15)));
                                      Future.delayed(Duration(seconds: 1)).then((value) {
                                        mapController!.showMarkerInfoWindow(markerId);
                                      });

                                      setState(() {
                                        released = true;
                                      });
                                    },
                                  );
                                },
                                separatorBuilder: (context,i)=>SizedBox(width: 12,),
                                itemCount: dataList.length
                            ),
                          ),
                        ),
                        loading?getLoader():Text('')
                      ],
                    ),
                  )
                ],
              );
            },
          )


        ),
      ),
    );
  }

  showLoader(){
    showDialog(context: context, builder: (context){
      return  AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Container(
          height: 50,
          width: 50,
          child: Row(
            children: [
              getLoader(),
              SizedBox(width: 18,),
              Expanded(child: Text("Getting offers...")
              ),
            ],
          ),
        ),
      );
    });
  }

  noDataFound(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Images.NO_DATA),
        SizedBox(height: 15,),
        Text(
          "No nearby offers found",
          style: FontStyle.PoppinsStyle(
              15,
              Color(ColorCodes.GOLDEN_COLOR).withOpacity(0.4),
              fontWeight: FontWeight.w600),)
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => keepAlive;
}
