import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/data/controller/trade/running_trade_details_controller/running_trade_details_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/custom_text_field.dart';



class ChatInputWidget extends StatelessWidget {



   const ChatInputWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<RunningTradeDetailsController>(builder: (controller)=>Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(color: MyColor.colorGrey1, width: 0.5)),
          color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50,
            child: Row(
              children: <Widget>[
                controller.fileChooserModel.fileName.toLowerCase()==MyStrings.noFileChosen.toLowerCase()?
                Container(
                  height:50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 8.0),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                      color: MyColor.transparentColor,
                      border: Border.all(color: MyColor.borderColor)
                  ),

                  child: GestureDetector(
                    onTap: (){
                      controller.pickFile();
                    },
                    child:  SvgPicture.asset(MyIcons.fileIcon,color: MyColor.primaryColor,height: 25,width: 25,),

                  )

                ):  Container(
                  height: 50,
                    width: 50,
              margin: const EdgeInsets.only(right: 10),
              child: Stack(
                children: [
                  controller.isFilePathIsPdf()? Center(child: SvgPicture.asset(MyIcons.pdfIcon,height: 25,width: 25,fit:BoxFit.cover,)):
                  GestureDetector(
                    onTap: (){
                      controller.pickFile();
                    },
                    child: Center(
                      child: Image.file(File(controller.fileChooserModel.choosenFile?.path??'',),fit:BoxFit.cover,height: 30,width: 30,errorBuilder:(context,object,trace){
                        return  SvgPicture.asset(MyIcons.errorIcon,color: MyColor.primaryColor,height: 25,width: 25,fit:BoxFit.cover,);
                      } ,),
                    ),
                  ),
                  Positioned(
                      top:0,
                      right:0,
                      child: CircleButtonWithIcon(
                          bg:MyColor.redCancelTextColor,
                          isShowBorder:false,
                          isIcon:true,
                          circleSize:25,
                          iconSize:17,
                          padding: 1,
                          press: (){
                            controller.clearChosenFile();
                          })),


                ],
              ),
            ),
                Flexible(
                  child:  SizedBox(
                    height: 50,
                    child: CustomTextField(
                      horizontalPadding: 10,
                      fillColor: MyColor.bgColor1,
                        controller: controller.chatFieldController,
                        hintText: MyStrings.typeAMessage.tr,
                        onChanged: (value){

                        }
                    ),
                  ),
                ),
                Container(
                  height: 50,width: 50,
                     padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                      color: MyColor.primaryColor800
                    ),
                    margin: const EdgeInsets.only(left: 8.0),
                    child: controller.storeChatLoading?const SizedBox(width:18,height: 18,child:CircularProgressIndicator(color: MyColor.primaryColor,),):GestureDetector(
                      onTap: (){
                          controller.storeChat();
                      },
                     child:  SvgPicture.asset(MyIcons.sendIcon,color: MyColor.primaryColor,height: 25,width: 25,),

                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}