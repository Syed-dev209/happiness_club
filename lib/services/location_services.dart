import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happiness_club/modules/auth/Model/user_model.dart';
import 'package:provider/provider.dart';

import 'navigatorKey.dart';

class LocationService{

  static LocationService _locationService = LocationService._internal();
  factory LocationService(){
      return _locationService;
  }
  LocationService._internal();

  static LatLng? currentLocation ;

Future<LatLng> getCurrentLocation(context)async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium);
  Provider.of<UserModelProvider>(GlobalVariable.navState.currentContext!,listen: false).setCurrentLocation(LatLng(position.latitude,position.longitude));
  return LatLng(position.latitude, position.longitude);
}


}