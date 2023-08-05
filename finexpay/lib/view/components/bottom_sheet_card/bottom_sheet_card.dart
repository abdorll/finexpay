import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';

class BottomSheetCard extends StatelessWidget {
  final Widget child;

  const BottomSheetCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.bgColor1,
          border: Border.all(color: MyColor.borderColor, width: .5),
        ),
        child: child);
  }
}
