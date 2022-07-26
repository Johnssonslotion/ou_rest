import 'package:flutter/material.dart';
import 'package:ou_rest/config/constants.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:ou_rest/config/route.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:go_router/go_router.dart';


class WideSidebarConfig extends StatelessWidget {
  const WideSidebarConfig({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: defaultAmber,
          borderRadius: BorderRadius.circular(10),
        ), // Default sidebar config => border
        textStyle: const TextStyle(color: Colors.white),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        // itemDecoration: BoxDecoration(
        //   border: Border.all(color: defaultAmberB),
        // ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
        margin: EdgeInsets.only(right: 10),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/avatar.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Call HOME');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        const SidebarXItem(
          icon: Icons.wheelchair_pickup,
          label: 'Favorite',
        ),
      ],
    );
  }
}


class navbar_bottom extends StatefulWidget {
  final int selectedIndex;
  final NavHandler navHandler;
  const navbar_bottom({
    required this.selectedIndex,
    required this.navHandler,
    Key? key}) : super(key: key);

  @override
  State<navbar_bottom> createState() => _navbar_bottomState();
}

class _navbar_bottomState extends State<navbar_bottom> {

  // var selectedPath == :
  
  @override
  Widget build(BuildContext context) {
   var width = MediaQuery.of(context).size.width;
   return FloatingNavbar(
        selectedBackgroundColor: Colors.white,
        iconSize: 24,
        borderRadius: 20,
        width: width * 0.5,
        currentIndex: widget.selectedIndex,
        onTap: (i) {
          widget.navHandler.currentTabIndex = i;
        },
        backgroundColor: Colors.amber,
        items: [
          FloatingNavbarItem(icon: Icons.home),
          FloatingNavbarItem(
            icon: Icons.map_outlined,
          ),
          FloatingNavbarItem(
            icon: Icons.bookmarks_outlined,
          ),
        ],
      );
  }
}













