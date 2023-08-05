import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

class MakeATradeShimmer extends StatelessWidget {
  const MakeATradeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                color: MyColor.colorWhite,
                border: Border.all(color: MyColor.bgColor1)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyShimmerEffectUI.rectangular(height: 25,width: 180,),
                  const SizedBox(height: 25,),
                  const MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                  const SizedBox(height: 15,),
                   Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                    color: MyColor.colorWhite,
                    border: Border.all(color: MyColor.bgColor1)
                ),
                  child: const MyShimmerEffectUI.rectangular(height: 40,width: double.infinity,)
              ),
                  const SizedBox(height: 15,),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.colorWhite,
                          border: Border.all(color: MyColor.bgColor1)
                      ),
                      child: const MyShimmerEffectUI.rectangular(height: 40,width: double.infinity,)
                  ),
                  const SizedBox(height: 15,),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.colorWhite,
                          border: Border.all(color: MyColor.bgColor1)
                      ),
                      child: const MyShimmerEffectUI.rectangular(height: 50,width: double.infinity,)
                  ),
                  const SizedBox(height: 15,),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.colorWhite,
                          border: Border.all(color: MyColor.bgColor1)
                      ),
                      child: const MyShimmerEffectUI.rectangular(height: 40,width: double.infinity,)
                  ),
                  const SizedBox(height: 15,),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.colorWhite,
                          border: Border.all(color: MyColor.bgColor1)
                      ),
                      child: Column(
                        children: const [
                          MyShimmerEffectUI.rectangular(height: 25,width: double.infinity,),
                          SizedBox(height: 15,),
                          MyShimmerEffectUI.rectangular(height: 25,width: double.infinity,),
                          SizedBox(height: 15,),
                          MyShimmerEffectUI.rectangular(height: 25,width: double.infinity,),
                          SizedBox(height: 15,)
                        ],
                      )
                  ),
                ]
              ),
            ),
              const SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.colorWhite,
                    border: Border.all(color: MyColor.bgColor1)
                ),
                child: Column(
                    children: const [
                      MyShimmerEffectUI.rectangular(height: 25,width: 180,),
                      SizedBox(height: 25,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,), MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                    ]
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.colorWhite,
                    border: Border.all(color: MyColor.bgColor1)
                ),
                child: Column(
                    children: const [
                      MyShimmerEffectUI.rectangular(height: 25,width: 180,),
                      SizedBox(height: 25,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                    ]
                ),
              ),
              const SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.colorWhite,
                    border: Border.all(color: MyColor.bgColor1)
                ),
                child: Column(
                    children: const [
                      MyShimmerEffectUI.rectangular(height: 25,width: 180,),
                      SizedBox(height: 25,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                      MyShimmerEffectUI.rectangular(height: 18,width: 100,),
                      SizedBox(height: 15,),
                    ]
                ),
              ),
          ],
          ),
        ),
      ),
    );
  }
}
