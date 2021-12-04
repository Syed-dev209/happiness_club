import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/home/Model/offers_model.dart';
import 'package:happiness_club/modules/home/widgets/dealCard.dart';
import 'package:happiness_club/services/location_services.dart';

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
    getCurrentLocation();
    keepAlive = true;
    updateKeepAlive();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    markers.add(Marker(
        markerId: MarkerId("1"),
        icon: customIcon??BitmapDescriptor.defaultMarker,
        position: currentPosition
    ));
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          GoogleMap(
            buildingsEnabled: true,
            indoorViewEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            compassEnabled: false,
            markers: markers.toSet(),
            onMapCreated: (controller){
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(bearing: 192.8334901395799, target: currentPosition, zoom: 10)
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: SizedBox(
          //     height: 210,
          //     width: double.maxFinite,
          //     child: ListView.separated(
          //         itemBuilder: (context,i){
          //           return DealCard(
          //               width: 161,
          //               smallBox: true,
          //               modelData: OffersModelData(),
          //               type: StorageKeys.FEATURED_OFFERS
          //           );
          //         },
          //         separatorBuilder: (context,i)=>SizedBox(width: 12,),
          //         itemCount: 10
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => keepAlive;
}
