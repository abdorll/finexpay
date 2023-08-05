import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/utils/dimensions.dart';
import '../../../../../../../core/utils/my_color.dart';

class WalletShimmerWidget extends StatelessWidget {
  const WalletShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(20, (index){
          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
              border: Border.all(color: MyColor.borderColor,width: 1),
            ),
            child: Shimmer.fromColors(
              baseColor: MyColor.bgColor1,
              highlightColor: MyColor.bgColor2,
               child:Column(
                  children: [
                    Row(
                      children: const [
                        MyShimmerEffectUI.circular(
                          height: 25,
                            width: 25,
                        ),
                        SizedBox(width: 10,),
                       MyShimmerEffectUI.rectangular(height: 15,width: 100,)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const MyShimmerEffectUI.rectangular(height: 12,width: 120,)
                  ],
                ),
            ),
          );
        }),
      ),
    );
  }
}
