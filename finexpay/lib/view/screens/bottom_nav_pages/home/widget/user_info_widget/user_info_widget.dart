import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/home/home_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(builder: (controller)=> Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: MyColor.primaryColor,
        image: DecorationImage(image: AssetImage(MyImages.homeBgImage),fit: BoxFit.cover)
      ),
      padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 65),
      child: Row(
        children: [
          CircleButtonWithIcon(bg:MyColor.colorWhite,isIcon: false,isAsset: false,imagePath: controller.getImage(),circleSize: 35,imageSize: 33,padding: 2,press: (){
            Get.toNamed(RouteHelper.profileScreen);
          },),
          const SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( controller.user?.username ?? '',style: mulishSemiBold.copyWith(color:MyColor.colorWhite,fontSize: Dimensions.fontLarge),),
              const SizedBox(height: 1,),
              Text( controller.user?.address?.country ?? "",style: robotoRegular.copyWith(color: MyColor.colorWhite),)
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              Get.toNamed(RouteHelper.notificationScreen)?.then((value) {
                controller.changeNewNotification(false);
              });
            },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColor.colorWhite
                ),
                  child: SvgPicture.asset(controller.hasNewNotification?MyIcons.activeNotificationIcon:MyIcons.inActiveNotificationIcon,height: 25,width: 25,)))
        ],
      ),
    ));
  }
}
