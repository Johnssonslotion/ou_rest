
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:toilet_app_refact/config/constants.dart';
import 'package:toilet_app_refact/widgets/map_component.dart';


class mapControl extends ChangeNotifier {
  final LatLng center     = const LatLng(37.5446953, 127.0599957);
  final LatLng gps_fake   = const LatLng(37.5446953, 127.0569957);
  final LatLng info_temp  = const LatLng(37.5446953, 127.0569957666);

  late bool enabled = false;
  late Position cords;


  final Completer<GoogleMapController> _controller = Completer();
  final CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  late Set<Marker> markers = {};
  late Set<Circle> circles = {};






  // void oninitMarker() {
  //   // cords = await _determinePosition();
  //   // print("cords");
  //   // circles.add(
  //   //     Circle(
  //   //       circleId: CircleId("GPS"),
  //   //       center: LatLng(cords.latitude, cords.longitude),
  //   //       radius: 20,
  //   //       fillColor: Colors.white,
  //   //       strokeColor: defaultAmber,
  //   //       strokeWidth: 10,
  //   //     )
  //   // );
  //   markers.add(
  //       Marker(
  //           markerId: const MarkerId("markerID"),
  //           position: info_temp,
  //           draggable: true,
  //           onTap: () {
  //             customInfoWindowController.addInfoWindow!(
  //                 const distanceMarker(dis_level: 0, dis_minute: 1),
  //                 info_temp
  //             );
  //           }
  //       )
  //   );
  // }

  //
  // void onMapCreated(GoogleMapController controller) async {
  //     circles.add(
  //         Circle(
  //           circleId: CircleId("GPS"),
  //           center: center,
  //           radius: 20,
  //           fillColor: Colors.white,
  //           strokeColor: defaultAmber,
  //           strokeWidth: 5,
  //         )
  //     );
  //
  //
  //   markers.add(
  //       Marker(
  //           markerId: const MarkerId("markerID"),
  //           position: info_temp,
  //           draggable: true,
  //           onTap: () {
  //             // GoRouter.of(context).go('/details');
  //             // customInfoWindowController.addInfoWindow!(
  //             //     const distanceMarker(dis_level: 0, dis_minute: 1),
  //             //     info_temp
  //             // );
  //           }
  //       )
  //   );
  //   _controller.complete(controller);
  // }


  void oninit() async {
    print("####################### map init ####################");
    enabled = await Geolocator.isLocationServiceEnabled();
    print("GPS status : $enabled");
    cords = await _determinePosition();

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
