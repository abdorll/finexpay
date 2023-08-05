import 'package:flutter/material.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/home/shimmer/custom_shimmer_effect.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/trade_shimmer/TradeShimmer.dart';

class MarketPlaceShimmer extends StatelessWidget {
  const MarketPlaceShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: const [
                Expanded(
                  child: MyShimmerEffectUI.rectangular(height: 40,width: 100,),
                ),
                 SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MyShimmerEffectUI.rectangular(height: 40,width: 100,),
                ),
               SizedBox(width: 10),
                Align(
                  alignment: Alignment.bottomLeft,
                  child:MyShimmerEffectUI.rectangular(height: 40,width: 40,),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Expanded(child: TradeShimmer())
        ],
      )
    );
  }
}
