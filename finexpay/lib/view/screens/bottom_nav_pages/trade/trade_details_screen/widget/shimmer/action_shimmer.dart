import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../../../../core/utils/my_color.dart';

class ActionShimmer extends StatelessWidget {
  const ActionShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(width: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: MyShimmerEffectUI.rectangular(height: 45,width: MediaQuery.of(context).size.width,)),
                const SizedBox(width: 20,),
                Expanded(child: MyShimmerEffectUI.rectangular(height: 45,width: MediaQuery.of(context).size.width,)),
              ],
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.transparentColor,
                  border: Border.all(color: MyColor.borderColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 MyShimmerEffectUI.rectangular(height: 20,width: MediaQuery.of(context).size.width,),
                  const SizedBox(
                    height: 5,
                  ),
                  MyShimmerEffectUI.rectangular(height: 20,width: MediaQuery.of(context).size.width,),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: MyColor.borderColor,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: MyColor.borderColor,
                            width: .5)),
                    child: MyShimmerEffectUI.rectangular(height: 40,width: MediaQuery.of(context).size.width,),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: MyColor.borderColor)),
                    child: MyShimmerEffectUI.rectangular(height: 60,width: MediaQuery.of(context).size.width,),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: MyShimmerEffectUI.rectangular(height: 45,width: MediaQuery.of(context).size.width,)),
                      const SizedBox(width: 20,),
                      Expanded(child: MyShimmerEffectUI.rectangular(height: 45,width: MediaQuery.of(context).size.width,)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: MyColor.borderColor)),
                    child: MyShimmerEffectUI.rectangular(height: 40,width: MediaQuery.of(context).size.width,),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
