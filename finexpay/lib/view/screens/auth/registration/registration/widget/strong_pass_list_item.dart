import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';

class StrongPasswordListItem extends StatelessWidget {
  const StrongPasswordListItem({Key? key,required this.text,this.isStrong = false}) : super(key: key);

  final String text;
  final bool isStrong;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.bgColor1,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          children: [
            Icon(
              isStrong?Icons.cancel:Icons.check_circle,
              size: 18,
              color: isStrong?Colors.red:Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text.tr,style: mulishRegular.copyWith(color: isStrong?Colors.red:Colors.green,fontSize: Dimensions.fontSmall),),
          ],
        ),
      ),
    );
  }
}
