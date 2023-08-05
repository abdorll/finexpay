import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/data/controller/withdraw/withdraw_controller.dart';
import 'package:local_coin/data/repo/withdraw/withdraw_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/main.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/custom_text_field.dart';
import 'package:local_coin/view/components/label_text.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/show_divider.dart';
import 'package:local_coin/view/screens/withdraw/withdraw_screen/widget/withdraw_shimmer.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';
import '../../../components/CustomNoDataFoundClass.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {

  int walletId=0;
  String titleCode='';
  @override
  void initState() {
    var data=Get.arguments;
    walletId=data[0];
    titleCode=data[1];
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    final controller=Get.put(WithdrawController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData(walletId);
    });
    //LockScreenManager.startTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      appBar:  CustomAppBar(title:'${MyStrings.withdraw.tr} $titleCode',isShowBackBtn: true,isShowActionBtn: true,),
      body:GetBuilder<WithdrawController>(builder: (controller)=> SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:controller.isLoading?const WithdrawShimmer() :controller.noInternet?NoDataOrInternetScreen(message2:'',isNoInternet: true,onChanged: (value){
          if(value){
            controller.changeNoInternetStatus(false);
            controller.initData(walletId);
          }
        },):
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: MyColor.bgColor1,
                      border: Border.all(color: MyColor.borderColor)
                  ),
                  child: Row(
                    children: [
                      CircleButtonWithIcon(
                         press: (){},
                        imagePath:controller.imagePath,
                        isAsset: false,
                        isIcon: false,
                        imageSize: 35,
                       padding: 0,
                       circleSize: 35,
                         bg: MyColor.transparentColor,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.currentBalance} ${controller.crypto?.code??''}",style: mulishSemiBold.copyWith(overflow: TextOverflow.ellipsis,fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
                            const SizedBox(
                              height:3 ,
                            ),
                            Text(
                              MyStrings.currentBalance.tr,
                              style: mulishLight.copyWith(
                                  color: MyColor.textColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12,bottom: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: MyColor.transparentColor,
                    border: Border.all(color: MyColor.borderColor)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('${controller.limit} ${controller.crypto?.code ?? ""}',
                               style:mulishSemiBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.warningColor),),
                             Text(MyStrings.maxLimit.tr,style:mulishLight.copyWith(
                                 color: MyColor.textColor) ,),
                           ],
                         )
                       ],
                     ),
                      const CustomDivider(),
                     Row(
                       children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.charge,
                              style:mulishSemiBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.redCancelTextColor),),
                            Text(MyStrings.charge.tr,
                                style: mulishLight.copyWith(
                                    color: MyColor.textColor)),
                          ],
                        )
                       ],
                     )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                const LabelText(text: MyStrings.walletAddress,style: mulishSemiBold,),
                CustomTextField(
                  fillColor: MyColor.colorWhite,
                  controller: controller.addressController,
                  hintText: MyStrings.enterYourWalletAddress,
                    onChanged: (value){

                }),
                const SizedBox(height: 15,),
                const LabelText(text: MyStrings.withdrawAmount,style: mulishSemiBold,),
                CustomTextField(
                  fillColor: MyColor.colorWhite,
                  controller: controller.amountController,
                  inputType: TextInputType.number,
                  hintText: MyStrings.enterYourWithdrawAmount,
                    onChanged: (value){
                    controller.changeCharge(double.tryParse(value.toString().isEmpty?'0':value));

                }),
                const SizedBox(height: 5,),
                Text("${MyStrings.charge.tr}: ${controller.withdrawCharge} ${controller.crypto?.code??""}",style: robotoRegular.copyWith(color: MyColor.primaryColor),),
                const SizedBox(height: 35,),
               controller.submitLoading?const RoundedLoadingBtn(): RoundedButton(text: MyStrings.submit, press: (){
                     controller.requestWithdraw(controller.addressController.text,controller.amountController.text);
                }),
               const SizedBox(height: 20,),
                Center(
                  child:TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(vertical: 0,horizontal: 10)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor:MaterialStateColor.resolveWith((states) => MyColor.bgColor1)),
                    onPressed: (){
                      Get.toNamed(RouteHelper.previousWithdrawalScreen,arguments: controller.cryptoId);
                    },
                    child: Text("${MyStrings.previous.tr} ${controller.crypto?.code??""} ${MyStrings.withdrawals.tr}",style: mulishSemiBold.copyWith(color:MyColor.colorBlack)),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}


