import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/styles.dart';


class ChipWidget extends StatelessWidget {
  const ChipWidget({
       Key? key,
       required this.name,
       required this.hasError
  }) : super(key: key);

  final String name;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          avatar: Icon(hasError?Icons.cancel:Icons.check_circle,color: hasError?Colors.red:Colors.green,size: 15,),
          shape: RoundedRectangleBorder(side:BorderSide(width:.5,color:hasError?Colors.red:Colors.green ),borderRadius: BorderRadius.circular(20) ),
          label: Text(
            name.tr,
            style: mulishRegular.copyWith(
              fontSize: Dimensions.fontExtraSmall,
              color: hasError?Colors.red:Colors.green,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 5,),
      ],
    );
  }
}