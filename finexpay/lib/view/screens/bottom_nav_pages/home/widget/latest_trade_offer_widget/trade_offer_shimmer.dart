import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../shimmer/custom_shimmer_effect.dart';


class AdvertisementShimmer extends StatelessWidget {
  const AdvertisementShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                border: Border.all(color: MyColor.borderColor, width: 1),
                color: MyColor.colorWhite
            ),
            child: Shimmer.fromColors(
              baseColor: MyColor.shimmerBaseColor,
              highlightColor: MyColor.shimmerSplashColor,
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        Dimensions.cornerRadius),
                    border: Border.all(color: MyColor.borderColor, width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Row(children: const [
                              MyShimmerEffectUI.circular(
                                height: 20,
                                width: 25,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              MyShimmerEffectUI.rectangular(
                                height: 20,
                                width: 50,
                              ),
                            ])),
                        const MyShimmerEffectUI.rectangular(
                          height: 20,
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MyShimmerEffectUI.rectangular(
                          height: 20,
                          width: 50,
                        ),
                        MyShimmerEffectUI.rectangular(
                          height: 20,
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.bgColor1),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                MyShimmerEffectUI.circular(
                                  height: 25,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                MyShimmerEffectUI.rectangular(
                                  height: 25,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: MyShimmerEffectUI.rectangular(
                                  height: 25,
                                  width: 50,
                                ),)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MyShimmerEffectUI.rectangular(
                          height: 25,
                          width: 50,
                        ),
                        MyShimmerEffectUI.rectangular(
                          height: 25,
                          width: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}