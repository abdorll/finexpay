import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

import '../../shimmer/custom_shimmer_effect.dart';

class LatestResultShimmer extends StatelessWidget {
  const LatestResultShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
        border: Border.all(color: MyColor.borderColor,width: 1),
        color: MyColor.colorWhite
      ),
      child: Shimmer.fromColors(
        baseColor: MyColor.shimmerBaseColor,
        highlightColor: MyColor.shimmerSplashColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyShimmerEffectUI.rectangular(height: 15,width: 80,),
            const SizedBox(height: 12,),
            IntrinsicHeight(
              child:Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                        border: Border.all(color: MyColor.borderColor,width: 1),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: MyColor.bgColor1,
                        highlightColor: MyColor.bgColor2,
                        child:Column(
                          children: const [
                            MyShimmerEffectUI.rectangular(height: 15,width: 90,),
                            SizedBox(height: 10,),
                            MyShimmerEffectUI.rectangular(height: 12,width: 90,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                        border: Border.all(color: MyColor.borderColor,width: 1),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: MyColor.bgColor1,
                        highlightColor: MyColor.bgColor2,
                        child:Column(
                          children: const [
                            MyShimmerEffectUI.rectangular(height: 15,width: 90,),
                            SizedBox(height: 10,),
                            MyShimmerEffectUI.rectangular(height: 12,width: 90,)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                        border: Border.all(color: MyColor.borderColor,width: 1),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: MyColor.bgColor1,
                        highlightColor: MyColor.bgColor2,
                        child:Column(
                          children: const [
                            MyShimmerEffectUI.rectangular(height: 15,width: 90,),
                           SizedBox(height: 10,),
                           MyShimmerEffectUI.rectangular(height: 12,width: 90,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ) ,
            )

          ],
        ),
      ),
    );
  }
}
