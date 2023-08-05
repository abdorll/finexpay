import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/trade/make_a_trade_request_controller/make_a_trade_controller.dart';
import 'package:local_coin/view/components/custom_text_field.dart';
import 'package:local_coin/view/components/custom_text_field_for_phone.dart';
import 'package:local_coin/view/components/label_text.dart';
import 'package:local_coin/view/components/rounded_button.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/text_field_container2.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/make_a_trade_screen/widget/custom_card.dart';

class InputWidget extends StatelessWidget {

  const InputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MakeATradeController>(builder: (controller)=>CustomCard(headerText: '', child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text((controller.ad.type=='1'?MyStrings.howMuchDoYouWantToSell:MyStrings.howMuchDoYouWantToBuy).tr,
          style: mulishSemiBold.copyWith(fontSize: Dimensions.fontLarge),),
        const SizedBox(height: 15,),
        const LabelText(text: MyStrings.iWillPay),
        TextFieldContainer2(
            fromRight: true,
            prefixWidgetValue: controller.ad.fiat?.code??'',
            isShowSuffixView: true,
            child: CustomTextFieldForPhone(
                controller: controller.payController,
                hintText: '0.00',
                inputType: TextInputType.number,
                withSuffix: true,
                onChanged: (value){
                  controller.changePayTextField(value);
                }), onTap: (){

        }),
        const SizedBox(height: 3,),
        controller.showMax || controller.showMin ?Text(controller.limitMessage.tr,style: mulishRegular.copyWith(color: MyColor.primaryColor),):const SizedBox(),
        const SizedBox(height: 15,),
        const LabelText(text: MyStrings.receive),
        TextFieldContainer2(
            fromRight: true,
            prefixWidgetValue: controller.ad.crypto?.code??'',
            isShowSuffixView: true,
            child: CustomTextFieldForPhone(
                controller: controller.receiveController,
                inputType: TextInputType.number,
                hintText: '0.00',
                withSuffix: true,
                onChanged: (value){
                  controller.changeReceiveTextField(value);
                }), onTap: (){

        }),
        const SizedBox(height: 15,),
        const LabelText(text: MyStrings.yourMessage),
        CustomTextField(
          enableOutlineColor: MyColor.borderColor,
          fillColor: MyColor.colorWhite,
            hintText: MyStrings.writeYourMessage,
            controller: controller.messageController,
            maxLines: 2,
            onChanged: (value){

            }),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline,size: 17,color: MyColor.colorGrey,),
            const SizedBox(width: 5,),
            Flexible(child: Text(MyStrings.writeAboutYourConvenientPaymentMethod.tr,style: mulishRegular.copyWith(color: MyColor.colorGrey),)),
          ],
        ),
        const SizedBox(height: 30,),
        controller.submitLoading?const RoundedLoadingBtn() : RoundedButton(text: MyStrings.tradeRequest, press: (){
          controller.submitTradeRequest();
        }),
        const SizedBox(height: 30,),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: MyColor.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.titleOne.tr,style: mulishSemiBold),
              const SizedBox(height:4,),
              Text(controller.titleTwo.tr,style: robotoRegular.copyWith(color: MyColor.textColor),)
            ],
          ),
        )
      ],
    )));
  }
}
