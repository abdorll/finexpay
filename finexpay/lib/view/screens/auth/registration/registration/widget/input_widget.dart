import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/components/label_text.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/components/validation_widget/validation_widget.dart';

import '../../../../../../constants/my_strings.dart';
import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/styles.dart';
import '../../../../../../data/controller/auth/auth/registration_controller.dart';
import '../../../../../components/custom_text_field_for_phone.dart';
import '../../../../../components/custom_text_form_field.dart';
import '../../../../../components/rounded_button.dart';
import '../../../../../components/text_field_container2.dart';
import 'country_text_field.dart';
import 'strong_pass_list_item.dart';



class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late GlobalKey<FormState> _formKey;


  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  double space=18;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
        builder: (controller) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(
                    height: space,
                  ),
                  CustomTextFormField(
                    isUnderline: true,
                    label: MyStrings.username,
                    fillColor: MyColor.bgColor1,
                    controller: controller.userNameController,
                    focusNode: controller.userNameFocusNode,
                    inputType: TextInputType.text,
                    nextFocus: controller.emailFocusNode,
                    hintText: MyStrings.enterYourUserName,
                    maxLines: 1,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return MyStrings.kUserNameNullError.tr;
                      } else if(value.length<6){
                        return MyStrings.kShortUserNameError.tr;
                      }
                      else {
                        return null;
                      }
                    },
                    onChanged: (value) {

                      return;
                    },
                  ),
                  SizedBox(
                    height: space,
                  ),

                  CustomTextFormField(
                      isUnderline: true,
                      label:MyStrings.email,
                      fillColor: MyColor.bgColor1,
                      controller: controller.emailController,
                      focusNode: controller.emailFocusNode,
                      hintText: MyStrings.enterYourEmail,
                      validator: (String? value) {
                        if (value!=null && value.isEmpty) {
                          return MyStrings.kEmailNullError.tr;
                        } else if(!MyStrings.emailValidatorRegExp.hasMatch(value??'')) {
                           return MyStrings.kInvalidEmailError.tr;
                        }else{
                          return null;
                        }
                      },
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        return;
                      }),
                  SizedBox(
                    height: space,
                  ),
                  CountryTextField(
                   press: () {
                      showModalBottomSheet(isScrollControlled:true,backgroundColor:Colors.transparent,context: context, builder: (BuildContext context){
                        return Container(
                          height: MediaQuery.of(context).size.height*.8,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 8,),
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 100,
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: MyColor.bgColor1,
                                  ),

                                ),
                              ),
                              const SizedBox(height: 15,),
                              Flexible(
                                child: ListView.builder(itemCount:controller.countryList.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: const Color(0x8034b0fc),
                                          onTap: (){
                                            controller.countryController.text = controller.countryList[index].country??'';
                                            controller.setCountryNameAndCode(controller.countryList[index].country??'',
                                                controller.countryList[index].countryCode??'', controller.countryList[index].dialCode??'');

                                            Navigator.pop(context);

                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }

                                            controller.mobileFocusNode.requestFocus();

                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color:MyColor.bgColor1),
                                            ),
                                            child: Text('+${controller.countryList[index].dialCode}  ${(controller.countryList[index].country)?.tr}'.tr,style: mulishSemiBold,),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        );
                      });
                    },
                    text:controller.countryName == null?MyStrings.selectACountry.tr:(controller.countryName)!.tr,
                  ),
                  controller.countryName == null
                      ? const SizedBox()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: space,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child:CustomTextFormField(
                                      isUnderline: true,
                                      label: MyStrings.phone,
                                      controller: TextEditingController(text: '+${controller.mobileCode}'),
                                      inputType: TextInputType.phone,
                                      fillColor: MyColor.bgColor1,
                                      disableColor: controller.hasMobileFocus?MyColor.primaryColor:MyColor.borderColor,
                                      hintText: MyStrings.enterYourPhone,
                                      isIcon: true,
                                      isEnabled: false,
                                      onChanged: (value) {
                                        return;
                                      },
                                    ),),
                                const SizedBox(width: 8,),
                                Expanded(
                                    flex: 6,
                                    child: Focus(
                                      onFocusChange: (hasFocus){
                                        controller.changeMobileFocus(hasFocus);
                                      },
                                      child: CustomTextFormField(
                                        isUnderline: true,
                                        label: '',
                                        controller: controller.mobileController,
                                        focusNode: controller.mobileFocusNode,
                                        inputType: TextInputType.phone,
                                        fillColor: MyColor.bgColor1,
                                        hintText: MyStrings.enterYourPhone,
                                        isIcon: true,
                                        onChanged: (value) {
                                          return;
                                        },
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                  SizedBox(
                    height: space,
                  ),
                  Visibility(
                      visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                      child: ValidationWidget(list: controller.passwordValidationRulse,)),
                  Focus(
                    onFocusChange: (hasFocus){
                      controller.changePasswordFocus(hasFocus);
                    },
                    child: CustomTextFormField(
                        isUnderline: true,
                        label: MyStrings.password,
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocusNode,
                        nextFocus: controller.confirmPasswordFocusNode,
                        hintText: MyStrings.enterYourPassword_,
                        isShowSuffixIcon: true,
                        fillColor: MyColor.bgColor1,
                        isPassword: true,
                        inputType: TextInputType.text,
                        validator: (String? value) {
                          return controller.validatPassword(value??'');
                        },
                        onChanged: (value) {
                          if(controller.checkPasswordStrength){
                            controller.updateValidationList(value);
                          }
                        }),
                  ),
                  SizedBox(
                    height: space,
                  ),
                  //const LabelText(text: MyStrings.confirmPassword),
                  CustomTextFormField(
                      isUnderline: true,
                      label: MyStrings.confirmPassword,
                      controller: controller.cPasswordController,
                      focusNode: controller.confirmPasswordFocusNode,
                      inputAction: TextInputAction.done,
                      isPassword: true,
                      fillColor: MyColor.bgColor1,
                      hintText: MyStrings.confirmYourPassword,
                      isShowSuffixIcon: true,
                      validator: (String? value) {
                        if (controller.passwordController.text.toLowerCase() !=
                            controller.cPasswordController.text.toLowerCase()) {
                          return MyStrings.kMatchPassError.tr;
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        return;
                      }),
                  SizedBox(
                    height: space,
                  ),
                  controller.needAgree
                      ? Row(
                    children: [
                      SizedBox(
                        child: Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                    width: 2, color: controller.agreeTC?Colors.transparent:Colors.black)),
                            activeColor:MyColor.primaryColor,
                            value: controller.agreeTC,
                            onChanged: (value) {
                              controller.updateAgreeTC();
                            }),
                      ),
                      Flexible(
                          child: Text.rich(TextSpan(
                              text: '${MyStrings.iAgreeWith.tr} ',
                              style: mulishRegular,
                              children: [
                                TextSpan(
                                    text: MyStrings.privacyAndPolicy.tr.toLowerCase(),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(
                                            RouteHelper.privacyScreen);
                                      },
                                    style: mulishBold.copyWith(
                                        color: Colors.red,
                                        decoration:
                                        TextDecoration.underline)),
                              ])))
                    ],
                  )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 30,
                  ),
                  controller.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          text: MyStrings.submit,
                          press: () {

                            if (_formKey.currentState!.validate()) {
                              controller.signUpUser();
                            }
                          },
                        ),
                ],
              ),
            ));
  }



  void showSheet(String value){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              minChildSize: 0.15,
              initialChildSize:0.55,
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        StrongPasswordListItem(text: MyStrings.oneCapitalLetter,isStrong: CustomValueConverter.checkError(value, 0),),
                        const SizedBox(height: 5,),
                        StrongPasswordListItem(text: MyStrings.oneSmallLetter,isStrong: CustomValueConverter.checkError(value, 1),),
                        const SizedBox(height: 5,),
                        StrongPasswordListItem(text: MyStrings.oneCharacter,isStrong: CustomValueConverter.checkError(value, 2),),
                        const SizedBox(height: 5,),
                        StrongPasswordListItem(text: MyStrings.oneNumber,isStrong: CustomValueConverter.checkError(value, 3),),
                        const SizedBox(height: 5,),
                        StrongPasswordListItem(text: MyStrings.sixCharacter,isStrong: CustomValueConverter.checkError(value, 4),)
                      ],
                    ),
                  ),
                );
              });
        });
  }


}
