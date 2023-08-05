import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/dialog/exit_dialog.dart';

import '../../../../../core/utils/my_color.dart';
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final bool isShowBackBtn;
  final Color bgColor;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;

  const CustomAppBar({Key? key,this.isProfileCompleted=false,this.fromAuth=false,this.isTitleCenter=false,this.bgColor=Colors.transparent,this.isShowBackBtn=true,required this.title, this.isShowActionBtn=false}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification =false;
  @override
  void initState() {
  final client= Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        hasNotification=client.sharedPreferences.getBool(SharedPreferenceHelper.hasNewNotificationKey)??false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn?AppBar(
      elevation: 0,
      leading:widget.isShowBackBtn? IconButton(onPressed: (){
        if(widget.fromAuth){
          Get.offAllNamed(RouteHelper.loginScreen);
        }else if(widget.isProfileCompleted){
         showExitDialog(Get.context!);
        }
        else{
          String previousRoute=Get.previousRoute;
          if(previousRoute=='/splash-screen'){
            Get.offAndToNamed(RouteHelper.homeScreen);
          }else{
              Get.back();
          }
        }
      },icon: const Icon(Icons.arrow_back,color: MyColor.colorBlack,),):const SizedBox.shrink(),
      backgroundColor: widget.bgColor,
      title: Text(widget.title.tr,style: robotoBold.copyWith(color: MyColor.colorBlack),),
      centerTitle: widget.isTitleCenter,
      actions: [
        widget.isShowActionBtn?Container(
          height: 30,width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColor.transparentColor
          ),
          child: InkWell(onTap: (){Get.toNamed(RouteHelper.notificationScreen)?.then((value) {
            setState(() {
              hasNotification=false;
            });
          });},child: SvgPicture.asset(hasNotification?MyIcons.activeNotificationIcon:MyIcons.inActiveNotificationIcon,height: 25,width: 25,)),
        ):const SizedBox.shrink(),
        const SizedBox(width: 10,)
      ],
    ):AppBar(
      elevation: 0,
      backgroundColor: widget.bgColor,
      title:Text(widget.title.tr,style: mulishSemiBold.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontLarge),),
      actions: [
      widget.isShowActionBtn?InkWell(onTap: (){Get.toNamed(RouteHelper.notificationScreen)?.then((value){
        setState(() {
          hasNotification=false;
        });
      });},child: SvgPicture.asset(hasNotification?MyIcons.activeNotificationIcon:MyIcons.inActiveNotificationIcon,height: 28,width: 28,)):const SizedBox.shrink(),
        const SizedBox(width: 10,) ],
      automaticallyImplyLeading: false,
    );
  }


}