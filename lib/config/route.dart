
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ou_rest/module/frontdetailview/front_detail_view.dart';
import 'package:ou_rest/module/frontview/front_view.dart';
import 'package:ou_rest/module/mapdetailview/map_datail_view.dart';
import 'package:ou_rest/module/mapdetailview/map_manage_view.dart';
import 'package:ou_rest/module/mapview/map_view.dart';








class NavHandler extends ChangeNotifier {
  final GoRouter rootRouter;
  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  set currentTabIndex(int v) {
    _currentTabIndex = v;
    notifyListeners();
  }

  NavHandler(this.rootRouter);


  final TabInfo frontTabInfo = TabInfo(
    id: 'Home',
    router: GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const frontView(),
          ),
          routes: [
            GoRoute(
              path: 'details',
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                child: frontDetailView(),
              ),
            ),
          ],
        ),
      ],
      // serrorPageBuilder: defaultErrorPageBuilder(),
    ),
  );

  final TabInfo mapTabInfo = TabInfo(
    id: 'Map',
    router: GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const mapView(),

          ),
            routes:[
              GoRoute(
                  path: 'details',
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: const mapDetailview(),
                  ),
                  routes:[
                    GoRoute(
                        path: 'manage',
                        pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          child: const mapMangeView(),

                        ),
                    )
                  ]
              )
            ]
        ),
      ],
      // errorPageBuilder: defaultErrorPageBuilder(),
    ),
  );
  final TabInfo bookTabInfo = TabInfo(
    id: 'bookMark',
    router: GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: mapDetailview(),
          ),
        ),
      ],
      // errorPageBuilder: defaultErrorPageBuilder(),
    ),
  );

  late final List<TabInfo> tabInfos = [
    frontTabInfo,
    mapTabInfo,
    bookTabInfo,
  ];
  

  ///////////////////  freeze code //////////////////////

  /// Navigate to a root [location] and change the bottom nav index accordingly
  void goToRoot(String location, {Object? extra}) {
    if (!location.startsWith("/")) {
      throw Exception("Root location doesn't start with slash: $location");
    }

    if (!location.endsWith("/")) {
      location = "$location/";
    }

    // Maybe handle it with a nested router
    for (var tabInfo in tabInfos) {
      final id = tabInfo.id;
      if (location.startsWith("/$id/")) {
        final thisTabIndex = tabInfos.indexOf(tabInfo);

        // Update current tab index with the new route
        currentTabIndex = thisTabIndex;

        _handleRootRouteWithTab(thisTabIndex, location, extra: extra);
        return;
      }
    }

    rootRouter.go(location, extra: extra);

    
  }

  void _handleRootRouteWithTab(int tabIndex, String location, {Object? extra}) {
    final splitted = location.split("/");

    // Remote first path (the tab id) to do a "relative" navigation
    String effectiveLocation = splitted.sublist(2).join("/");
    if (!effectiveLocation.startsWith("/")) {
      effectiveLocation = "/$effectiveLocation";
    }

    final currentRouter = tabInfos[tabIndex].router;
    currentRouter.go(effectiveLocation, extra: extra);
  }


  ///////////////////  freeze code //////////////////////

}

/////////////////// freeze code //////////////////////
class TabInfo {
  final String id;
  final GoRouter router;

  TabInfo({required this.id, required this.router});
}


///////////////////  freeze code //////////////////////