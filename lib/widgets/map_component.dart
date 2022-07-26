
import 'package:flutter/material.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:ou_rest/config/constants.dart';


class distanceMarker extends StatelessWidget {
  final int dis_level;
  final int dis_minute;
  const distanceMarker({
    required this.dis_level,
    required this.dis_minute,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infocolor = Colors.white;
    switch (dis_level) {
      case 0:
        infocolor = info_low;
        break;
      case 1:
        infocolor = info_mid;
        break;
      case 2:
        infocolor = info_low;
        break;
      default:
        infocolor = info_low;
    }
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: infocolor,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                      "${dis_minute}분거리",
                      style: const TextStyle(fontSize: 10,)
                  )],
              ),
            ),
          ),
        ),
        Triangle.isosceles(
          edge: Edge.BOTTOM,
          child: Container(
            color: infocolor,
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    );
  }
}
