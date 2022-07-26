// import 'package:flutter/material.dart';
// import 'package:toilet_app_refact/config/route.dart';
// import 'package:toilet_app_refact/module/frontview/front_view.dart';
// import 'package:toilet_app_refact/modules/sectionView.dart';
// import 'package:toilet_app_refact/navigation.dart';
// import 'package:sidebarx/sidebarx.dart';


// class layout extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorKey;
//   final SidebarXController controller;

//   layout({
//     required this.controller, 
//     required this.navigatorKey, 
//     Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;

//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       var width_layout = constraints.minWidth;
//       var height_layout = constraints.minHeight;

//       if (constraints.maxWidth > 600) {
//         return Scaffold(
//             //appBar: AppBar(title: Text("wide")),
//             body: AnimatedBuilder(
//                 animation: this.controller,
//                 builder: (BuildContext context, child) {
//                   return Row(
//                     children: [
//                       Flexible(
//                           flex: 1,
//                           child: navbar(
//                             controller: this.controller,
//                           )),
//                       Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: sectionView(
//                             widgets: [
//                               Text("section 1 space check ${width}")
//                               ],
//                           )),
//                       Flexible(
//                           flex: 1,
//                           fit: FlexFit.tight,
//                           child: sectionView(
//                             widgets: [
//                               Text("section 2 space check")
//                               ],
//                           ))
//                     ],
//                   );
//                 }));
//       } else {
//         return Scaffold(
//             body: Navigator(
//             key: navigatorKey,
//           ///덧붙일수 있는
//             initialRoute: Routes.root,
//             onGenerateRoute: (routeSettings) {
//               if (routeSettings.name == "/"){
//                 return MaterialPageRoute(
//                   builder: (context) => frontView()
//                 );
//               }
//         },
//         ));
//       }
//     });
//   }
// }



