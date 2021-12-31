import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/colorCodes.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/widgets/dealCard.dart';
import 'package:happiness_club/modules/home/widgets/deal_shimmer_card.dart';
import 'package:happiness_club/modules/nearby/nearby_controller.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/modules/offers/Widget/offer_card_shimmer.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:happiness_club/constants/fontStyles.dart';

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

  loadData()async{
    await getCurrentLocation();
    getNearbyOffers(currentPosition).then((value) {
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
              for(var i in dataList){
                if(i!.longitude!=null && i.latitude!=null){
                  double lat = double.parse(i.latitude??"0.0");
                  double long = double.parse(i.longitude??"0.0");
                  markers.add(Marker(
                    markerId: MarkerId("${i.id}"),
                    icon: customIcon!,
                    position: LatLng(lat,long),
                    infoWindow: InfoWindow(
                      title: "${i.title}"
                    )
                  ));
                }
              }
              return Stack(
                children: [
                  GoogleMap(
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
                        mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 1)));
                      },
                      initialCameraPosition: CameraPosition(bearing: 192.8334901395799, target: currentPosition, zoom: 5)
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 220,
                      width: double.maxFinite,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        scrollDirection: Axis.horizontal,
                          itemBuilder: (context,i){
                            return DealCard(
                                width: 161,
                                smallBox: true,
                                modelData: dataList[i]!,
                                type: StorageKeys.FEATURED_OFFERS
                            );
                          },
                          separatorBuilder: (context,i)=>SizedBox(width: 12,),
                          itemCount: dataList.length
                      ),
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
