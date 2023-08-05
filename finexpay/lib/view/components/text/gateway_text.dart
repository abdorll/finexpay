import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';

import '../../../core/utils/styles.dart';

class GatewayText extends StatelessWidget {
  final String rate;
  final String currency;
  const GatewayText({Key? key,required this.rate,required this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text.rich(
          TextSpan(
          text: "${MyStrings.rate.tr}: $rate\n",
          style: mulishRegular,
          children: [
            TextSpan(
                text: currency,
                style: mulishRegular.copyWith(fontSize: Dimensions.fontOverSmall,)),
          ])),
    );
  }
}
