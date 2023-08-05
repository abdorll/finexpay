import 'package:flutter/material.dart';
import 'package:local_coin/view/components/label_column/label_column_shimmer.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';

import '../../../../../../core/utils/my_color.dart';

class NewAdvertisementShimmer extends StatelessWidget {
  const NewAdvertisementShimmer({Key? key}) : super(key: key);
  final bool showPadding=false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(showPadding?10:2),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(child: LabelColumnShimmer()),
               SizedBox(
                width: 20,
              ),
              Expanded(child: LabelColumnShimmer()),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Divider(
            color: MyColor.borderColor,
          ),
          const SizedBox(
            height: 12,
          ),
          const MyShimmerEffectUI.rectangular(height: 20,width: 150,),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(child: LabelColumnShimmer()),
              SizedBox(
                width: 20,
              ),
              Expanded(child:LabelColumnShimmer()),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: LabelColumnShimmer(),
              ),
               SizedBox(
                width: 12,
              ),
              Expanded(
                child: LabelColumnShimmer(),
              ),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          const LabelColumnShimmer(),
          const SizedBox(
            height: 22,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: LabelColumnShimmer(),
              ),
              SizedBox(
                width: 12,
              ),
               Expanded(
                child: LabelColumnShimmer(),
              ),
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          const LabelColumnShimmer(),
          const SizedBox(
            height: 22,
          ),
          const LabelColumnShimmer(),
          const SizedBox(
            height: 22,
          ),
          const LabelColumnShimmer(),
          const SizedBox(
            height: 35,
          ),
         const MyShimmerEffectUI.rectangular(height: 35,width: double.infinity,),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
