import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/components/header_text.dart';

import '../../../../../../core/utils/styles.dart';



class HeadingTextWidget extends StatelessWidget {
  const HeadingTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height *.025,
        ), // 4%
        const HeaderText(text: MyStrings.createAnAccount),
        const SizedBox(height: 5,),
        Padding(
          padding: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width*.3),
          child: Text(MyStrings.enterValidInfoToCreateAccount.tr,style: mulishRegular.copyWith(color: MyColor.textColor),),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height *.03,
        ),
      ],
    );
  }
}
