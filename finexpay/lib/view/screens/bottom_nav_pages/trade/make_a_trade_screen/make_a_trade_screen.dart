import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/core/helper/shared_pref_helper.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/data/controller/trade/make_a_trade_request_controller/make_a_trade_controller.dart';
import 'package:local_coin/data/repo/trade/trade_repo/trade_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/make_a_trade_screen/widget/info_widget.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/make_a_trade_screen/widget/make_a_trade_shimmer.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/make_a_trade_screen/widget/showDialog.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_icons.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../components/buttons/circle_button_with_icon.dart';
import 'widget/input_widget.dart';



class MakeATradeScreen extends StatefulWidget {
  const MakeATradeScreen({Key? key}) : super(key: key);

  @override
  State<MakeATradeScreen> createState() => _MakeATradeScreenState();
}

class _MakeATradeScreenState extends State<MakeATradeScreen> {


  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<MakeATradeController>().loadPaginationData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<MakeATradeController>().hasNext()) {
        fetchData();
      }
    }
  }


  @override
  void initState() {
    
    int tradeId=Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TradeRepo(apiClient: Get.find()));
   final controller =  Get.put(MakeATradeController(repo: Get.find()));

   controller.tradeId=tradeId;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page=0;
      controller.loadData();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MakeATradeController>(builder: (controller)=> Scaffold(
      backgroundColor: MyColor.bgColor1,
      appBar: CustomAppBar(title: controller.heading.isNotEmpty?controller.heading:'',bgColor: MyColor.colorWhite,),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:controller.isLoading?  const MakeATradeShimmer() :controller.noInternet?NoDataOrInternetScreen(isNoInternet: true,onChanged: (value){
          if(value){
            controller.page=0;
            controller.loadData();
          }
        },): SingleChildScrollView(
          controller: _controller,
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputWidget(),
                const InfoWidget(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Card(
                    color: MyColor.colorWhite,
                    margin: const EdgeInsets.all(0),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(MyStrings.feedbacks,style: robotoBold.copyWith(fontSize:Dimensions.fontLarge,color: MyColor.colorBlack),),
                          const SizedBox(height: 8,),
                          controller.reviewList.isEmpty?SizedBox(height:MediaQuery.of(context).size.height*.7,width:MediaQuery.of(context).size.width,child: const NoDataOrInternetScreen(fromReview: true,message: 'No Feedback Found',message2: MyStrings.emptyFeedbackMsg,)):ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: controller.reviewList.length+1,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {

                                if (controller
                                    .reviewList.length ==
                                    index) {
                                  return controller.hasNext()
                                      ? const Center(
                                      child:
                                      CircularProgressIndicator(color: MyColor.primaryColor,))
                                      : const SizedBox();
                                }

                                bool myAdd=controller.reviewList[index].userId==controller.repo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userIdKey);
                                bool positive=controller.reviewList[index].type.toString()=='0'?false:true;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: MyColor.borderColor),
                                      borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
                                     color: MyColor.colorWhite,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                CircleButtonWithIcon(press: (){

                                                },circleSize: 45,imageSize: 30,padding: 0,isAsset:false,isIcon: false,imagePath: controller.reviewList[index].image??MyImages.defaultAvatar,),
                                                const SizedBox(width: 10,),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text (controller.reviewList[index].username??'',overflow: TextOverflow.ellipsis,
                                                              style:mulishRegular.copyWith(fontSize: Dimensions.fontLarge,)),
                                                          myAdd?CircleButtonWithIcon(press:(){
                                                            if(myAdd){
                                                              controller.updateReviewType(controller.reviewList[index].type.toString()=='0'?false:true);
                                                              showReviewDialog(index,context,controller.reviewList[index].feedback??'');
                                                            }else{
                                                              CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.feedbackEditErrorMsg], msg:[], isError: true);
                                                            }
                                                          },
                                                            isIcon: true,
                                                            imagePath: MyIcons.editIcon,
                                                            iconColor: MyColor.primaryColor,
                                                            bg: MyColor.colorWhite,
                                                            padding: 4,
                                                            borderColor: MyColor.transparentColor,
                                                            circleSize: 25,
                                                            iconSize: 13,
                                                            isSvg: true,):const SizedBox(),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(positive?MyIcons.likeIcon:MyIcons.dislikeIcon,color:positive? MyColor.greenSuccessColor: MyColor.redCancelTextColor,height: 12,width: 12,),
                                                              const SizedBox(width: 5,),
                                                              Text( positive?MyStrings.positive.tr:MyStrings.negative.tr,style: mulishRegular.copyWith(fontSize:Dimensions.fontSmall,color:positive?MyColor.greenSuccessColor:MyColor.redCancelTextColor),)
                                                            ],
                                                          ),
                                                          Text ('${DateConverter.isoStringToLocalDateOnly(controller.reviewList[index].createdAt??'')}, ${DateConverter.isoStringToLocalTimeOnly(controller.reviewList[index].createdAt??'')}',overflow: TextOverflow.ellipsis,
                                                              style:mulishRegular.copyWith(fontStyle:FontStyle.italic,color: MyColor.colorGrey4,fontSize: Dimensions.fontSmall)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                     const SizedBox(height: 10,),
                                     Text(controller.reviewList[index].feedback.toString().tr,style: mulishRegular.copyWith(color: MyColor.textColor),)
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }



}
