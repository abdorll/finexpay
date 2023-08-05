import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/client_profile_controller/client_profile_controller.dart';
import 'package:local_coin/data/repo/client_profile_repo/client_profile_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/row_item/icon_with_text.dart';
import 'package:local_coin/view/components/row_item/custom_row.dart';
import 'package:local_coin/view/screens/account/profile/body/profile_shimmer.dart';
import 'package:local_coin/view/screens/bottom_nav_pages/trade/trade_details_screen/widget/acition_widget/show_divider.dart';
import 'package:local_coin/view/screens/client_profile_screen/profile_widget/buy_add_list_widget.dart';
import 'package:local_coin/view/screens/client_profile_screen/profile_widget/image_widget.dart';
import 'package:local_coin/view/screens/client_profile_screen/profile_widget/sell_add_list.dart';
import 'package:local_coin/view/screens/client_profile_screen/radius_card.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({Key? key}) : super(key: key);

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {


  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<ClientProfileController>().loadPaginationData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<ClientProfileController>().hasNext()) {
        fetchData();
      }
    }
  }

  
  @override
  void initState() {
    String username=Get.arguments;
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ClientProfileRepo(apiClient: Get.find()));
   final controller= Get.put(ClientProfileController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData(username);
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: MyColor.bgColor1,
      appBar: const CustomAppBar(title: MyStrings.publicProfile,bgColor: MyColor.colorWhite,),
      body: GetBuilder<ClientProfileController>(builder: (controller)=> SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: controller.isLoading?const Padding(
            padding: EdgeInsets.all(10),
              child: ProfileShimmer()):SingleChildScrollView(
            controller: _controller,
            child:Column(
              children: [
               Container(
                 margin: const EdgeInsets.all(10),
                 width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     RadiusCard(child: Column(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const SizedBox(height: 10,),
                             ProfileImageWidget(
                               imagePath:  '${controller.user?.image}',
                             ),
                             const SizedBox(height: 10,),
                             Center(child: Text(controller.user?.username??'---',style: mulishSemiBold.copyWith(fontSize: Dimensions.fontExtraLarge),)),
                             const SizedBox(height: 2,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 const Icon(Icons.location_on_outlined,size: 18,color: MyColor.primaryColor,),
                                 // SvgPicture.asset(MyIcons.transferNewIcon,height: 20,width: 20,),
                                 const SizedBox(width: 5,),
                                 Text(controller.user?.address?.country??'---',style: mulishRegular,),
                               ],
                             ),
                             const SizedBox(height: 2,),
                           ],
                         ),
                         const SizedBox(height: 5,),
                         const CustomDivider(),
                         const SizedBox(height: 5,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             IconWithText(text: controller.positiveReviewCount??'00',iconColor: MyColor.greenSuccessColor,iconUrl: MyIcons.likeIcon,),
                             Text('|',style: mulishRegular.copyWith(color: MyColor.bgColor2),),
                             IconWithText(text: controller.negativeReviewCount??'00',iconUrl: MyIcons.dislikeIcon,iconColor: MyColor.redCancelTextColor,),
                             Text('|',style: mulishRegular.copyWith(color: MyColor.bgColor2),),
                             IconWithText(text: controller.totalReviewCount??'00',iconUrl:MyIcons.allIcon ,iconColor: MyColor.primaryColor,),
                           ],
                         ),
                         const SizedBox(height: 5,),
                       ],
                     )),
                     const SizedBox(height: 8,),
                     RadiusCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRow(firstText: MyStrings.joined, lastText:DateConverter.isoStringToLocalDateOnly(controller.user?.createdAt??'')),
                        CustomRow(firstText: MyStrings.totalTrade, lastText:controller.user?.completedTrade??'00',showDivider: true,),
                        CustomRow(firstText: MyStrings.emailVerified, lastText:'',showDivider: true,hasChild: true ,child:controller.getIcon(controller.user?.ev=='1'?'1':'0'),),
                        CustomRow(firstText: MyStrings.phoneVerified, lastText:'',showDivider: true,hasChild: true ,child:controller.getIcon(controller.user?.sv=='1'?'1':'0'),),
                        CustomRow(firstText: MyStrings.kycVerified, lastText:'',showDivider: false,hasChild: true ,child:controller.getIcon(controller.user?.kv=='1'?'1':'0'),),
                      ],
                    )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColor.bgColor,

                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                if(!controller.isBuyAddSelected){
                                  controller.changeTabMenu();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.cornerRadius),bottomLeft: Radius.circular(Dimensions.cornerRadius)),
                                  color: controller.isBuyAddSelected?MyColor.primaryColor:MyColor.bgColor1,
                                ),
                                child:  Text(MyStrings.buy,style: mulishSemiBold.copyWith(color: controller.isBuyAddSelected?MyColor.colorWhite:MyColor.colorBlack),),
                              ),
                            ),
                          ),
                          Expanded(child:  InkWell(
                            onTap: (){
                              if(controller.isBuyAddSelected){
                                controller.changeTabMenu();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.cornerRadius),bottomRight: Radius.circular(Dimensions.cornerRadius)),
                                color: !controller.isBuyAddSelected?MyColor.primaryColor:MyColor.bgColor1,
                              ),
                              child:  Text(MyStrings.sell,style: mulishSemiBold.copyWith(color: !controller.isBuyAddSelected?MyColor.colorWhite:MyColor.colorBlack),),
                            ),


                          ),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      controller.isBuyAddSelected?const BuyAddList(): const SellAddListWidget()
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    ));
  }
}
