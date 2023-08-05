
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/route/route.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/messages.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/localization/localization_controller.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/language/language_model.dart';
import 'package:local_coin/data/repo/auth/general_setting_repo.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';


class LanguageDialogBody extends StatefulWidget {
  final List<LanguageModel>langList ;
  final bool fromSplashScreen;
  const LanguageDialogBody({Key? key,required this.langList,this.fromSplashScreen = false}) : super(key: key);

  @override
  State<LanguageDialogBody> createState() => _LanguageDialogBodyState();
}

class _LanguageDialogBodyState extends State<LanguageDialogBody> {

  int pressIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Text(MyStrings.selectALanguage,style: mulishRegular.copyWith(color:MyColor.colorBlack,fontSize: Dimensions.fontLarge),),),
          const SizedBox(height: 15,),
          Flexible(child: ListView.builder(
              shrinkWrap: true,
              itemCount:  widget.langList.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: ()async{
                    setState(() {
                      pressIndex = index;
                    });
                    String languageCode = widget.langList[index].languageCode;
                    final repo = Get.put(GeneralSettingRepo(apiClient: Get.find()));
                    final localizationController = Get.put(LocalizationController(sharedPreferences: Get.find()));
                    ResponseModel response = await repo.getLanguage(languageCode);
                    if(response.statusCode == 200){
                      try{
                        Map<String,Map<String,String>> language = {};
                        var resJson = jsonDecode(response.responseJson);
                        await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, response.responseJson);
                        var langKeyList = jsonDecode(resJson['data']['file']);
                        Map<String,String> json = {};
                        if(langKeyList is Map<String,dynamic>){
                          langKeyList.forEach((key, value) {
                            json[key] = value.toString();
                          });
                        }
                        language['${widget.langList[index].languageCode}_${'US'}'] = json;
                        Get.clearTranslations();
                        Get.addTranslations(Messages(languages: language).keys);

                        Locale local = Locale(widget.langList[index].languageCode,'US');
                        localizationController.setLanguage(local);
                        if(widget.fromSplashScreen){
                          Get.offAndToNamed(RouteHelper.loginScreen,);
                        }else{
                          Get.back();
                        }
                      }catch(e){
                        CustomSnackbar.showCustomSnackbar(errorList: [e.toString()],msg: [],isError: true);
                      }

                    } else{
                      CustomSnackbar.showCustomSnackbar(errorList: [response.message],msg: [],isError: true);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                    decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.cornerRadius)),
                    child: pressIndex==index?const  Center(
                      child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: MyColor.primaryColor)),
                    ):Text(( widget.langList[index].languageName).tr,
                      style: mulishRegular.copyWith(color: MyColor.colorBlack),
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
