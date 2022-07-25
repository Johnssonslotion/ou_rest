import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toilet_app_refact/config/constants.dart';
import 'package:toilet_app_refact/module/mapview/map_control.dart';
import 'package:toilet_app_refact/widgets/searchbar.dart';


class mapView extends StatelessWidget {
  const mapView({

    Key? key}) : super(key: key);


  Widget category(){
    return Container(
      width: 400,
      height: 200,
      color : Colors.black45,
      child: Text("hello"),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => mapControl(),
          child: Stack(
              fit: StackFit.expand,
              children:  [
              mapActiveView(),
              searchBar(),
              category(),

        ]
    ),
    )
    );
  }
}















class mapActiveView extends StatefulWidget {
  const mapActiveView({
    // required this.cords,
    Key? key}) : super(key: key);

  @override
  State<mapActiveView> createState() => _mapActiveViewState();
}

class _mapActiveViewState extends State<mapActiveView> {
  ///// linked value

  final LatLng center     = const LatLng(37.5446953, 127.0599957);
  final LatLng gps_fake   = const LatLng(37.5446953, 127.0569957);
  final LatLng info_temp  = const LatLng(37.5446953, 127.0569957666);

  final Completer<GoogleMapController> _controller = Completer();
  final CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};

  void onMapCreated(GoogleMapController controller) {
    circles.add(
        Circle(
          circleId: CircleId("GPS"),
          center: center,
          radius: 20,
          fillColor: Colors.white,
          strokeColor: defaultAmber,
          strokeWidth: 5,
        )
    );


    markers.add(
        Marker(
            markerId: const MarkerId("markerID"),
            position: info_temp,
            draggable: true,
            onTap: () {
              print("tapped");
              GoRouter.of(context).go("/details");
              // customInfoWindowController.addInfoWindow!(
              //     const distanceMarker(dis_level: 0, dis_minute: 1),
              //     info_temp
            }
        )
    );
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    //// map data from provider
    // void Function(GoogleMapController) onMapCreated =  context.watch<mapControl>().onMapCreated;

    markers.add(
        Marker(
            markerId: const MarkerId("markerID"),
            position: info_temp,
            draggable: true,
            onTap: () {
              print("tapped");
              GoRouter.of(context).go("/details");
              GoRouter.of(context).go("details");
              // customInfoWindowController.addInfoWindow!(
              //     const distanceMarker(dis_level: 0, dis_minute: 1),
              //     info_temp
            }
        )
    );
    void Function(GoogleMapController) _onMapCreated =  this.onMapCreated;
    // final Set<Marker> markers = this.markers;
    // final Set<Circle> circles = this.circles;

    // final Set<Marker> markers = context.watch<mapControl>().markers;
    // final Set<Circle> circles = context.watch<mapControl>().circles;
    // final Set<Marker> circles = context.watch<mapControl>().circles;
    // final CameraPosition initCam =




    return Scaffold(
      body: Stack(
        children:[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: context.watch<mapControl>().center,
              zoom: 15.0,
            ),
            // cameraTargetBounds: LatLngBounds(LatLng) ,
            markers: markers,
            circles: circles,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,



        ),
        CustomInfoWindow(controller:
        context.watch<mapControl>().customInfoWindowController
        ),
    ]),
    );
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // mapControl().oninit();
    //mapControl().oninitMarker();
    print("activate_provider");
  }
}




