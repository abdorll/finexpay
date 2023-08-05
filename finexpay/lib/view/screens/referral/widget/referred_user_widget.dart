import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/small_text.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_screen/widget/trade_shimmer/TradeShimmer.dart';

import '../../../../data/controller/referral_controller/referral_controller.dart';
import '../../../components/CustomNoDataFoundClass.dart';

class ReferredUserWidget extends StatefulWidget {
  const ReferredUserWidget({Key? key}) : super(key: key);

  @override
  State<ReferredUserWidget> createState() => _ReferredUserWidgetState();
}

class _ReferredUserWidgetState extends State<ReferredUserWidget> {


  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<ReferralController>().loadInitialReferralUser();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if(Get.find<ReferralController>().hasNext(true)){
        fetchData();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final controller=Get.find<ReferralController>();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      controller.commissionIndex=0;
      controller.loadInitialReferralUser();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ReferralController>(builder: (controller)=>controller.isLoading? const Expanded(
        child: TradeShimmer())
        :controller.userDataList.isEmpty?const Expanded(child: NoDataOrInternetScreen(message2: MyStrings.emptyReferredLogMsg,)): Expanded(
          child: ListView.builder(
              itemCount: controller.userDataList.length,
              itemBuilder: ((context, index) {

                if(index==controller.userDataList.length){
                  return Center(
                    child: controller.hasNext(true)?const CircularProgressIndicator(color: MyColor.primaryColor,):const SizedBox(),
                  );
                }

            return GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.clientProfileScreen,arguments: controller.userDataList[index].username??'');
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                  border: Border.all(color: MyColor.borderColor,width: 1),
                  color: MyColor.transparentColor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                   CircleButtonWithIcon(press: (){},isIcon: false,isAsset: false,padding: 0,imageSize: 35,circleSize: 35,imagePath:controller.userDataList[index].image??'' ,),
                   const SizedBox(width: 15,),
                    Expanded(child:
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SmallText(text: MyStrings.username),
                            SmallText(text: MyStrings.level),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.userDataList[index].username??'',style: mulishRegular,),
                            Text(CustomValueConverter.getTrailingExtension(controller.getFormattedValue(controller.userDataList[index].level??'0')),style: robotoRegular.copyWith(color: MyColor.colorBlack),),
                          ],
                        ),
                        const SizedBox(height: 8,),
                      ],
                    ))
                  ],
                ),
              ),
            );
          })),
        ));
  }
}
