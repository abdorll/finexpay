
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';



class CountDownTimer extends StatelessWidget {
  final int remMin;
  final VoidCallback onEnd;
  const CountDownTimer({Key? key,required this.remMin,required this.onEnd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: MyColor.primaryColor,

        ),
        child: Row(
          children: [
            TimerCountdown(
              format: CountDownTimerFormat.minutesSeconds,
              timeTextStyle: mulishRegular.copyWith(color: MyColor.colorWhite),
              enableDescriptions: false,
              colonsTextStyle: mulishRegular.copyWith(color: MyColor.colorWhite),
              spacerWidth: 1,
              endTime: DateTime.now().add(
                Duration(
                  days: 0,
                  hours: 0,
                  minutes:remMin,
                  seconds: 0,
                ),
              ),
              onEnd: onEnd,
            ),
            const SizedBox(width: 3,),
            Text(MyStrings.minutes.tr,style: mulishRegular.copyWith(color: MyColor.colorWhite),)
          ],
        ),
      ),
    );
  }
}

