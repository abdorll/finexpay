import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../../core/utils/my_color.dart';

class WalletAddressShimmer extends StatelessWidget {
  const WalletAddressShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index){
        return Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: MyColor.borderColor)),
          child: Row(
            children: [
              const MyShimmerEffectUI.circular(height: 25,width: 25,),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyShimmerEffectUI.rectangular(height: 15,width: 120,),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        MyShimmerEffectUI.rectangular(height: 20,width: 20,),
                        SizedBox(
                          width: 10,
                        ),
                        MyShimmerEffectUI.rectangular(height: 15,width: 110,),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const MyShimmerEffectUI.rectangular(height: 22,width: 35,)
            ],
          ),
        );
      });
  }
}
