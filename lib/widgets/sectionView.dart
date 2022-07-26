import 'package:flutter/material.dart';

class sectionView extends StatelessWidget {
  final List<Widget> widgets;
  const sectionView({required this.widgets, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var widgetWidth = (MediaQuery.of(context).size.width > 600)
        ? MediaQuery.of(context).size.width * 0.4
        : MediaQuery.of(context).size.width;
    var widgetHeight = (MediaQuery.of(context).size.width > 600)
        ? MediaQuery.of(context).size.height * 0.95
        : MediaQuery.of(context).size.height * 0.3;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
          constraints: BoxConstraints(
            minWidth: widgetWidth,
            maxWidth: double.infinity,
            minHeight: widgetHeight,
            maxHeight: double.infinity,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.amber),
          child: Column(children: widgets)),
    );
  }
}
