
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:toilet_app_refact/widgets/map_component.dart';


class mapControl extends ChangeNotifier{
  final LatLng center=const LatLng(37.33,126.58);
  final LatLng info_temp=const LatLng(37.33,126.58);
  late bool enabled = false;
  late Position cords;

  final Completer<GoogleMapController> _controller = Completer();
  final CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  Set<Marker> markers = {};


  void onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }







   void oninit() async {
    print("####################### map init ####################");

     enabled = await Geolocator.isLocationServiceEnabled();
     print("GPS status : $enabled");
     if (enabled == true){
       cords = _determinePosition() as Position;
       print(cords);
     } else {
      print("GPS can't initized");
     }
     markers.add(
         Marker(
             markerId: const MarkerId("markerID"),
             position: info_temp,
             onTap:(){
               customInfoWindowController.addInfoWindow!(
                   const distanceMarker(dis_level: 0, dis_minute: 1),
                   info_temp
               );
             }
         )
     );
   }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }




}






