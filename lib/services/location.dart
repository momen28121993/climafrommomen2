import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {

  late double longtude ;
  late double latitude;
   late LocationPermission permission;

  Future<void> getlocation() async {
   permission = await Geolocator.requestPermission();



try {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low);
  longtude = position.longitude;
  latitude = position.latitude;
}
catch(e){
  if (kDebugMode) {
    print(e);
  }
}

      }
    }

