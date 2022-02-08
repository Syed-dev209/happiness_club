import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:happiness_club/modules/nearby/nearby_controller.dart';
import 'package:happiness_club/modules/offers/Controller/offers_controller.dart';
import 'package:happiness_club/modules/offers/Models/offer_location_model.dart';
import 'package:happiness_club/services/location_services.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:provider/provider.dart';


class OfferLocation extends StatefulWidget {
  String? offerId;
  OfferLocation({required this.offerId});

  @override
  _OfferLocationState createState() => _OfferLocationState();
}

class _OfferLocationState extends State<OfferLocation> with AutomaticKeepAliveClientMixin{
  bool keepAlive= false;
  GoogleMapController? mapController;
  BitmapDescriptor? customIcon;
  List<Marker> markers=[];
  StreamController<OfferLocationModel?>? streamController;
  LatLng? currentPos;
  LatLng? offerPos;
  final Set<Polyline> _polylines = Set();

  loadData()async{
    currentPos = Provider.of<UserModelProvider>(context,listen: false).currentLocation!;
    getOffersLocation(offerId: widget.offerId.toString()).then((value) {
      if(value!=null){
        streamController!.add(value);
        return value;
      }
      else{
        streamController!.add(null);
        return null;
      }
    });
    markers.add(Marker(
        markerId: MarkerId("1"),
        icon: BitmapDescriptor.defaultMarker,
        position: currentPos!
    ));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamController = StreamController<OfferLocationModel?>();
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(8, 8)),
        Images.OFFER_MARKER)
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

    return StreamBuilder<OfferLocationModel?>(
      stream: streamController!.stream,
        builder: (context,snapshot){
          if(snapshot.hasError || !snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data == null){
            return Text("Unable to find location");
          }
          for(int i=0;i<snapshot.data!.data!.length;i++){
            double lat = double.parse(snapshot.data!.data![i]!.latitude??"0.00");
            double long = double.parse(snapshot.data!.data![i]!.longitude??"0.0");
            markers.add(Marker(
              markerId: MarkerId("marker$i"),
              icon: customIcon!,
              position: LatLng(lat,long)
            ));
            offerPos = LatLng(lat, long);
            _polylines.add(
                Polyline(
                  polylineId: PolylineId("line$i"),
                  visible: true,
                  width: 4,
                  patterns: [PatternItem.dash(2), PatternItem.gap(0)],
                  points: MapsCurvedLines.getPointsOnCurve(currentPos!, offerPos!), // Invoke lib to get curved line points
                  color: Colors.red,
                )
            );
          }
          double lat =0.0;
          double long = 0.0;
          if(snapshot.data!.data!=null){
            lat = double.parse(snapshot.data!.data!.first!.latitude??"0.0");
            long = double.parse(snapshot.data!.data!.first!.longitude??"0.0");
          }

          return Container(
            child: GoogleMap(
              polylines: _polylines,
              zoomControlsEnabled: false,
              markers: markers.toSet(),
              initialCameraPosition: CameraPosition(bearing: 192.8334901395799, target: LatLng(37.43296265331129, -122.08832357078792), zoom: 19.151926040649414),
              onMapCreated: (controller){
                mapController = controller;
                mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 10)));
              },
            ),
          );
        }
    );



  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => keepAlive;
}
