import 'package:flutter/material.dart';

import '../../../core/utils/my_color.dart';

class RadiusCard extends StatelessWidget {
  final Widget child;
  final double padding;

  const RadiusCard({Key? key, required this.child,this.padding=10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Card(
            color: MyColor.bgColor,
            margin: const EdgeInsets.all(0),
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: child,
            )));
  }
}
