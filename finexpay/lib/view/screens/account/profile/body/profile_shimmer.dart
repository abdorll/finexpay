import 'package:flutter/material.dart';
import 'package:local_coin/view/components/label_column/label_column_shimmer.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: 12,
          ),
          Center(child: MyShimmerEffectUI.circular(height: 100,width: 100,),),
          SizedBox(
            height: 12,
          ),
          LabelColumnShimmer(),
          SizedBox(
            height: 12,
          ),
         LabelColumnShimmer(),
         SizedBox(
            height: 12,
          ),
          LabelColumnShimmer(),
          SizedBox(
            height: 12,
          ),
          LabelColumnShimmer(),
          SizedBox(
            height: 12,
          ),
          LabelColumnShimmer(),
          SizedBox(
            height: 12,
          ),
          LabelColumnShimmer(),
          SizedBox(
            height: 12,
          ),
          MyShimmerEffectUI.rectangular(height: 35,width: double.infinity,),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
