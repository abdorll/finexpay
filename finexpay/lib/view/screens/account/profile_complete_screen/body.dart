
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/data/controller/auth/profile_complete_controller.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/account/profile/body/profile_shimmer.dart';

import '../../../../../../../../core/utils/my_color.dart';
import '../../../../../constants/my_strings.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/label_text.dart';
import '../../../components/rounded_button.dart';
import '../profile/body/profile_image.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCompleteController>(builder: (controller)=>
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColor.bgColor,
          ),
          child: controller.isLoading? const ProfileShimmer():SingleChildScrollView(
            child:Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  ProfileWidget(
                    isEdit:  false,
                      imagePath:  MyImages.defaultAvatar,
                      onClicked: () async {

                      }
                  ),
                const SizedBox(height: 10,),
                const SizedBox(height: 2,),
                const LabelText(text: MyStrings.firstName,top: 12,isRequired: true),
                  CustomTextField(
                    hintText: MyStrings.firstName,
                    isShowBorder: true,
                    isPassword: false,
                    isShowSuffixIcon: false,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusNode: controller.firstNameFocusNode,
                    controller: controller.firstNameController,
                    validator: (value){
                      if(value.toString().isEmpty){
                        return MyStrings.kFirstNameNullError.tr;
                      } else{
                        return null;
                      }
                    },
                    onChanged: (value) {

                      return;
                    },
                    nextFocus: controller.lastNameFocusNode,
                  ),
                const SizedBox(height: 15,),
                const LabelText(top: 12,text: MyStrings.lastName,isRequired: true),
                  CustomTextField(
                    hintText: MyStrings.lastName,
                    isShowBorder: true,
                    isPassword: false,
                    isShowSuffixIcon: false,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusNode: controller.lastNameFocusNode,
                    controller: controller.lastNameController,
                    validator: (value){
                      if(value.toString().isEmpty){
                        return MyStrings.kLastNameNullError.tr;
                      } else{
                        return null;
                      }
                    },
                    onChanged: (value) {

                      return;
                    },
                    nextFocus: controller.addressFocusNode,
                  ),
                const SizedBox(height: 15,),
                const LabelText(top: 12,text: MyStrings.address),
                  CustomTextField(
                    hintText: MyStrings.address,
                    isShowBorder: true,
                    isPassword: false,
                    isShowSuffixIcon: false,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusNode: controller.addressFocusNode,
                    controller: controller.addressController,
                    onSuffixTap: () {},
                    onChanged: (value) {

                      return;
                    },
                    nextFocus: controller.stateFocusNode,
                  ),
                const SizedBox(height: 15,),
                const LabelText(top: 12,text: MyStrings.state),
                  CustomTextField(
                    hintText: MyStrings.state,
                    isShowBorder: true,
                    isPassword: false,
                    isShowSuffixIcon: false,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusNode: controller.stateFocusNode,
                    controller: controller.stateController,
                    onSuffixTap: () {},
                    onChanged: (value) {
                      return;
                    },
                    nextFocus: controller.zipCodeFocusNode,
                  ),
                const SizedBox(height: 15,),
                const LabelText(top: 12,text: MyStrings.zipCode),
                  CustomTextField(
                    hintText: MyStrings.zipCode,
                    isShowBorder: true,
                    isPassword: false,
                    isShowSuffixIcon: false,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusNode: controller.zipCodeFocusNode,
                    controller: controller.zipCodeController,
                    onSuffixTap: () {},
                    onChanged: (value) {

                      return;
                    },
                    nextFocus: controller.cityFocusNode,
                  ),
                const SizedBox(height: 15,),
                const LabelText(top: 12,text: MyStrings.city),
                  CustomTextField(
                    hintText: MyStrings.city,
                    isShowBorder: true,
                    isPassword: false,
                    isShowSuffixIcon: false,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    focusNode: controller.cityFocusNode,
                    controller: controller.cityController,
                    onSuffixTap: () {},
                    onChanged: (value) {

                      return;
                    },
                  ),

                  const SizedBox(height: 30,),
                  controller.submitLoading?const RoundedLoadingBtn():RoundedButton(text:MyStrings.completeProfile, press: (){
                    if(formKey.currentState!.validate()){
                      controller.updateProfile();
                    }
                  })
                ],
              ),
            ),
          ),
        ));
  }
}
