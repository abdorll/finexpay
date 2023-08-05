import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/styles.dart';
import '../../../../../core/utils/my_color.dart';

import '../../../core/route/route.dart';

class CustomBottomNav extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNav({Key? key,required this.currentIndex}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  final autoSizeGroup = AutoSizeGroup();
  var bottomNavIndex = 0; 


  final iconList = <String>[
    MyIcons.homeIcon,
    MyIcons.walletIcon,
    MyIcons.marketPlaceIcon,
    MyIcons.tradeIcon,
    MyIcons.menuIcon
  ];

  final textList = [
    MyStrings.home,
    MyStrings.wallet,
    MyStrings.market,
    MyStrings.trade,
    MyStrings.menu
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      elevation: 0,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? MyColor.primaryColor : MyColor.colorBlack;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconList[index],
              height: 20,
              width: 20,
              fit: BoxFit.cover,
              color: isActive?MyColor.primaryColor:MyColor.colorGrey2,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: AutoSizeText(
                textList[index].tr,
                maxLines: 1,
                style: robotoRegular.copyWith(color: color),
                group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      backgroundColor: MyColor.bgColor1,
      borderColor: MyColor.borderColor,
      splashColor: MyColor.colorWhite,
      splashSpeedInMilliseconds: 300,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.none,
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      onTap: (index) {
        _onTap(index);
      },
      activeIndex: bottomNavIndex,
    );
  }


  void _onTap(int index) {

    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    }

    else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAndToNamed(RouteHelper.walletScreen);
      }
    }

    else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAndToNamed(RouteHelper.marketPlaceScreen);
      }
    }

    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAndToNamed(RouteHelper.tradeScreen);
      }
    }


    else if (index == 4) {
      if (!(widget.currentIndex == 4)) {
        Get.offAndToNamed(RouteHelper.menuScreen);
      }
    }


  }
}




  


