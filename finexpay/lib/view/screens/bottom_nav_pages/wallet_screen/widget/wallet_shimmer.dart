
import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';

class WalletShimmer extends StatelessWidget {

  const WalletShimmer(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:
      const EdgeInsets.symmetric(horizontal: Dimensions.screenPadding),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                  border: Border.all(color: MyColor.borderColor, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          MyShimmerEffectUI.circular(height: 15,width: 25,),
                           SizedBox(
                            width: 12,
                          ),
                          MyShimmerEffectUI.rectangular(height: 15,width: 100,)
                        ],
                      ),
                      const MyShimmerEffectUI.rectangular(height: 15,width: 60,),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const MyShimmerEffectUI.rectangular(height: 20,width: 200,),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    color: MyColor.borderColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColor.bgColor1),
                        child: const MyShimmerEffectUI.rectangular(height: 15,width: 70,)
                        ,
                      ),
                      const Spacer(),
                      const MyShimmerEffectUI.rectangular(height: 15,width: 70,),
                      const SizedBox(
                        width: 10,
                      ),
                      const MyShimmerEffectUI.rectangular(height: 15,width: 70,),
                    ],
                  ),
                ],
              ),
            );
          }),
      
    );
  }
  
}