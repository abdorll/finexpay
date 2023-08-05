import 'package:flutter/material.dart';

import '../../../bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';


class PrivacyPolicyShimmer extends StatefulWidget {
  const PrivacyPolicyShimmer({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyShimmer> createState() => _PrivacyPolicyShimmerState();
}

class _PrivacyPolicyShimmerState extends State<PrivacyPolicyShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 15,
      itemBuilder: (context, index){
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: const MyShimmerEffectUI.rectangular(height: 20,width: 120,),
                ),
                const SizedBox(height: 15,),
                const SizedBox(height:50,child: MyShimmerEffectUI.rectangular(height: 50,))
              ],
            ),

        );
      });
  }
}
