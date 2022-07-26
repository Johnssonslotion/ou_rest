import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ou_rest/config/constants.dart';
import 'package:ou_rest/module/mapview/map_control.dart';
import 'package:ou_rest/widgets/searchbar.dart';
import 'package:provider/provider.dart';


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
              // category(),

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

  final List<LatLng> info_temp = [
    LatLng(37.5446953, 127.0569957666),
     LatLng(37.5476953, 127.0568957666),
    LatLng(37.5246953, 127.0570957666),
    LatLng(37.5436953, 127.0569657666),
    LatLng(37.5406953, 127.0569957666),
  ];


  final LatLng ne     = const LatLng(37.5446953+0.01, 127.0599957+0.01);
  final LatLng sw     = const LatLng(37.5446953-0.01, 127.0599957-0.01);

  late GoogleMapController _controller;
  final CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};

  void onMapCreated(GoogleMapController controller) {
    for(int i = 0; i>5 ;i++){
      markers.add(
        Marker(
            markerId: MarkerId(i as String),
            position: info_temp[i],
            // draggable: true,
            onTap: () {
              print("tapped");
              GoRouter.of(context).go("/details");
            }
        ),
      );}
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

    _controller=controller;
  }

  @override
  Widget build(BuildContext context) {
    //// map data from provider
    // void Function(GoogleMapController) onMapCreated =  context.watch<mapControl>().onMapCreated;


    //void Function(GoogleMapController) _onMapCreated =  this.onMapCreated;
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
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: context.watch<mapControl>().center,
              zoom: 15.0,
            ),
            cameraTargetBounds: new CameraTargetBounds( LatLngBounds(
              northeast: ne,
              southwest: sw,
            )),
            markers: markers,
            circles: circles,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,

        ),
        CustomInfoWindow(controller: customInfoWindowController,
          height: 75,
          width: 150,
          offset: 50,
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

  }
}




