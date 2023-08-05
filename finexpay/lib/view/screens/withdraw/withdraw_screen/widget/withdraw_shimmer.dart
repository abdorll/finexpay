import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../../core/utils/my_color.dart';

class WithdrawShimmer extends StatelessWidget {
  const WithdrawShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1,
                  border: Border.all(color: MyColor.borderColor)
              ),
              child: Row(
                children:  [
                 const MyShimmerEffectUI.circular(height: 25,width: 25),
                   const SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        MyShimmerEffectUI.rectangular(height: 20,width: 120,),
                         SizedBox(
                          height:3 ,
                        ),
                        MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1,
                  border: Border.all(color: MyColor.borderColor)
              ),
              child: const MyShimmerEffectUI.rectangular(height: 20,width: 120,)
            ),
            Container(
              margin: const EdgeInsets.only(top: 12,bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1,
                  border: Border.all(color: MyColor.borderColor)
              ),
               child: const MyShimmerEffectUI.rectangular(height: 20,width: 120,)
              ),
            const SizedBox(height: 10,),
            const MyShimmerEffectUI.rectangular(height: 20,width: 90,),
            const SizedBox(height: 12,),
            Container(
                margin: const EdgeInsets.only(top: 12,bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.bgColor1,
                    border: Border.all(color: MyColor.borderColor)
                ),
                child: const MyShimmerEffectUI.rectangular(height: 25,width: double.infinity,),
            ),
            const SizedBox(height: 15,),
            const MyShimmerEffectUI.rectangular(height: 20,width: 90,),
            const SizedBox(height: 12,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1,
                  border: Border.all(color: MyColor.borderColor)
              ),
              child: const MyShimmerEffectUI.rectangular(height: 25,width: double.infinity,),
            ),
            const SizedBox(height: 5,),
            const MyShimmerEffectUI.rectangular(height: 20,width: 120,),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1,
                  border: Border.all(color: MyColor.borderColor)
              ),
              child: const MyShimmerEffectUI.rectangular(height: 25,width: double.infinity,),
            ),
            const SizedBox(height: 20,),
            const Center(
              child:MyShimmerEffectUI.rectangular(height: 35,width: 120,),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
