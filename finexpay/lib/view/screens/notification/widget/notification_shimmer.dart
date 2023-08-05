import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

class NotificationShimmer extends StatefulWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  State<NotificationShimmer> createState() => _NotificationShimmerState();
}

class _NotificationShimmerState extends State<NotificationShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
        itemBuilder: ((context, index) {
      return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MyColor.bgColor1),
            color: MyColor.colorWhite),
        child: ListTile(
           leading: const MyShimmerEffectUI.circular(height: 30,width: 30,),
          title: const MyShimmerEffectUI.rectangular(height: 18,width: 100,),
          subtitle: Row(
            children: const [
              MyShimmerEffectUI.circular(height: 18,width: 18,),
               SizedBox(
                width: 5,
              ),
              MyShimmerEffectUI.rectangular(height: 18,width: 100,),
            ],
          ),
        ),
      );
    }));
  }
}
