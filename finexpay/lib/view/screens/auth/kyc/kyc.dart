import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/rounded_loading_button.dart';
import 'package:local_coin/view/screens/account/profile/body/profile_shimmer.dart';
import 'package:local_coin/view/screens/auth/kyc/widget/already_verifed.dart';
import 'package:local_coin/view/screens/auth/kyc/widget/file_item.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/styles.dart';
import '../../../../data/controller/kyc_controller/kyc_controller.dart';
import '../../../../data/model/kyc/KycResponseModel.dart';
import '../../../../data/repo/kyc/kyc_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app_bar/custom_appbar.dart';
import '../../../components/check_box/custom_check_box.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/drop_down_button/custom_drop_down_button_with_text_field.dart';
import '../../../components/radio_button/custom_radio_button.dart';
import '../../../components/rounded_button.dart';
import '../../../components/row_item/form_row.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(KycRepo(apiClient: Get.find()));
    Get.put(KycController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<KycController>().beforeInitLoadKycData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(
      builder: (controller) =>
          Scaffold(
            backgroundColor: MyColor.colorWhite,
            appBar:  const CustomAppBar(title: MyStrings.kycData,bgColor: MyColor.colorWhite,),
            body: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child:
                controller.isLoading?const Padding(padding:EdgeInsets.all(Dimensions.screenPadding),child: ProfileShimmer()):controller.isAlreadyVerified?const AlreadyVerifiedWidget():controller.isAlreadyPending?
                const AlreadyVerifiedWidget(isPending: true,):
                controller.isNoDataFound? const NoDataOrInternetScreen(message: MyStrings.noData,message2: MyStrings.goBackLogMsg,):
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding:  const EdgeInsets.all(Dimensions.fontExtraLarge),
                      margin: Dimensions.dialogContainerMargin,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColor.colorWhite,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 1), // changes position of shadow
                            ),
                          ]
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Text(MyStrings.kycInfo.tr,style: mulishSemiBold,),
                          const SizedBox(height: 20,),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: controller.formList.length,
                              itemBuilder: (ctx,index){
                                FormModel? model=controller.formList[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      model.type=='text'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          const SizedBox(height: 10,),
                                          CustomTextField(
                                              hintText: model.name??'',
                                              onChanged: (value){
                                                controller.changeSelectedValue(value, index);
                                              }),
                                        ],
                                      ):model.type=='textarea'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          const SizedBox(height: 10,),
                                          CustomTextField(
                                              maxLines: 3,
                                              hintText: model.name??'',
                                              onChanged: (value){
                                                controller.changeSelectedValue(value, index);
                                              }),
                                        ],
                                      ):model.type=='select'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomDropDownTextField(list: model.options??[],onChanged: (value){
                                            controller.changeSelectedValue(value,index);
                                          },selectedValue: model.selectedValue,),
                                        ],
                                      ):model.type=='radio'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomRadioButton(title:model.name,selectedIndex:controller.formList[index].options?.indexOf(model.selectedValue??'')??0,list: model.options??[],onChanged: (selectedIndex){
                                            controller.changeSelectedRadioBtnValue(index,selectedIndex);
                                          },),
                                        ],
                                      ):model.type=='checkbox'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                          CustomCheckBox(selectedValue:controller.formList[index].cbSelected,list: model.options??[],onChanged: (value){
                                            controller.changeSelectedCheckBoxValue(index,value);
                                          },),
                                        ],
                                      ):model.type=='file'?Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FormRow(label: model.name??'', isRequired: model.isRequired=='optional'?false:true),
                                             Padding(
                                               padding: const EdgeInsets.all(15),
                                               child:FileWidget(index: index),
                                             )
                                        ],
                                      ):const SizedBox(),

                                      const SizedBox(height: 5,),

                                    ],
                                  ),
                                );
                              }
                          ),

                          const SizedBox(height: 30,),
                          controller.isLoading
                              ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme
                                        .of(context)
                                        .primaryColor),
                              )) :
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: controller.submitLoading?const RoundedLoadingBtn(): RoundedButton(
                                press: () {
                                  controller.submitKycData();
                                },
                                text: MyStrings.submit.tr,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ),
    );
  }
}
