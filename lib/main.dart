import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ou_rest/config/route.dart';
import 'package:ou_rest/firebase_options.dart';
import 'package:ou_rest/navigation.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding?.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,  // -> authService 쪽으로 merge
  );

  runApp(info());
}

class info extends StatelessWidget {
  info({Key? key}) : super(key: key);

  final _rootRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context,state)=> MaterialPage(
              key: state.pageKey,
              child: const HomePage()
          ),
          routes: [
            GoRoute(
                path: 'pushed',
                pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    child: Scaffold(appBar: AppBar(),body:const Text('Pushed'))
                )
            )
          ]    ////bottom navi포함한 outline

      ),

    ],
    errorPageBuilder: defaultErrorPageBuilder(),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavHandler>
      (
      create: (_) => NavHandler(_rootRouter),
      child: MaterialApp.router(
        routeInformationParser: _rootRouter.routeInformationParser,
        routerDelegate: _rootRouter.routerDelegate,
        //routeInformationProvider: _rootRouter.routeInformationProvider,
        title: 'Toilet refact',
      ),
    );
  }
}





//////////////


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navHandler = context.watch<NavHandler>();
    final currentIndex = navHandler.currentTabIndex;

    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: List.generate(
            navHandler.tabInfos.length,
                (index) {
              return buildTab(context, index, navHandler);
            },
          ),
        ),
        extendBody: true,
        bottomNavigationBar: navbar_bottom(
            selectedIndex: currentIndex,
            navHandler: navHandler
        )
        //BottomNav(currentIndex, navHandler)
    );
  }

  Widget buildTab(BuildContext context, int index, NavHandler navHandler) {
    final isActive = navHandler.currentTabIndex == index;
    return ActiveTabWrapper(
      isActive: isActive,
      child: Router(
        routerDelegate: navHandler.tabInfos[index].router.routerDelegate,
      ),
    );
  }
}


class ActiveTabWrapper extends StatelessWidget {
  const ActiveTabWrapper({
    Key? key,
    required this.child,
    required this.isActive,
  }) : super(key: key);

  final Widget child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: isActive,
      child: Offstage(
        offstage: !isActive,
        child: TickerMode(
          enabled: isActive,
          child: child,
        ),
      ),
    );
  }
}

Widget BottomNav(
    currentIndex,
    navHandler){
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (i) {
      navHandler.currentTabIndex = i;
    },
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        label: 'Front',
        icon: Icon(Icons.feed),
      ),
      BottomNavigationBarItem(
        label: 'Map',
        icon: Icon(Icons.search),
      ),
      // BottomNavigationBarItem(
      //   label: 'Front',
      //   icon: Icon(Icons.feed),
      // )
    ],
  );
}

GoRouterPageBuilder defaultErrorPageBuilder() {
  return (BuildContext context, GoRouterState state) {
    var a=state.error;
    return const MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text("Not found"),
        ),
      ),
    );
  };
}