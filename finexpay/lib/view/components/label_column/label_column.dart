import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';

class LabelColumn extends StatelessWidget {
  final double space;
  final Widget child;
  final String title;
  final bool isFixedSize;
  final double height;
  final bool isRequired;
  final VoidCallback? press;
  final bool showToolTip;

  const LabelColumn(
      {Key? key,
      this.showToolTip = false,
      this.press,
      this.isRequired = false,
      this.height = 45,
      this.space = 10,
      this.title = "",
      required this.child,
      this.isFixedSize = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRequired
            ? Row(
                children: [
                  Text(
                    title.tr,
                    style: mulishSemiBold.copyWith(color: MyColor.textColor2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: press,
                      child: const Icon(Icons.info_outline,color: MyColor.primaryColor,size: 15,)),
                  Text(
                    '*',
                    style: mulishSemiBold.copyWith(color: MyColor.primaryColor),
                  )
                ],
              )
            : Text(
                title.tr,
                style: mulishSemiBold.copyWith(color: MyColor.textColor2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        SizedBox(
          height: space,
        ),
        isFixedSize ? SizedBox(height: height, child: child) : child,
      ],
    );
  }
}
