
import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

class LabelColumnShimmer  extends StatelessWidget {


  const LabelColumnShimmer ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyShimmerEffectUI.rectangular(height:17,width: 90,),
        const SizedBox(height: 15,),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: MyColor.borderColor,width: .5)
          ),
            child: const MyShimmerEffectUI.rectangular(height: 40,width: double.infinity,))
      ],
    );
  }
}
