import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/withdraw/previous_withdraw_controller.dart';
import 'package:local_coin/data/repo/withdraw/withdraw_repo.dart';
import 'package:local_coin/data/services/api_service.dart';
import 'package:local_coin/view/components/CustomNoDataFoundClass.dart';
import 'package:local_coin/view/components/app_bar/custom_appbar.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/row_item/custom_row.dart';
import 'package:local_coin/view/screens/transactions/shimmer/list_shimmer.dart';

import '../../../../core/utils/dimensions.dart';


class PreviousWithdrawScreen extends StatefulWidget {
  const PreviousWithdrawScreen({Key? key}) : super(key: key);

  @override
  State<PreviousWithdrawScreen> createState() => _PreviousWithdrawScreenState();
}

class _PreviousWithdrawScreenState extends State<PreviousWithdrawScreen> {

  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<PreviousWithdrawController>().initData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<PreviousWithdrawController>().hasNext()) {
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

   int id=Get.arguments;
   Get.put(ApiClient(sharedPreferences: Get.find()));
   Get.put(WithdrawRepo(apiClient: Get.find()));
  final controller= Get.put(PreviousWithdrawController(repo: Get.find()));


    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page=0;
      controller.cryptoId=id;
      controller.initData();
      _controller.addListener(_scrollListener);
    });

  }
  int currentIndex=-1;
  void changeExpandIndex(int index){
    setState(() {
      currentIndex=index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.bgColor,
      appBar: const CustomAppBar(title: MyStrings.previousWithdrawals,isShowBackBtn: true,isShowActionBtn: true,),
      body: GetBuilder<PreviousWithdrawController>(builder: (controller)=> Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: controller.isLoading?const SizedBox(child: TransactionShimmer()):controller.withdrawList.isEmpty?const NoDataOrInternetScreen(message2: MyStrings.previousWithdrawEmptyMsg,):ListView.builder(
          itemCount: controller.withdrawList.length+1,
            controller: _controller,
            itemBuilder: (context, index){
              if (controller
                  .withdrawList.length ==
                  index) {
                return controller.hasNext()
                    ? const Center(
                    child:
                    CircularProgressIndicator(color: MyColor.primaryColor,))
                    : const SizedBox();
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: MyColor.borderColor,width: 1)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                       CircleButtonWithIcon(press:(){},isIcon:false,circleSize:30,imageSize:30,padding:0,imagePath: controller.imagePath,isAsset: false,),
                        const SizedBox(width: 12,),
                        Expanded(
                          flex: 5,
                          child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 Text(MyStrings.amount,style:mulishRegular.copyWith(color: MyColor.hintTextColor),),
                                  const SizedBox(height: 2,),
                                  Text("${controller.withdrawList[index].amount} ${controller.withdrawList[index].crypto?.code}",
                                      style: robotoBold.copyWith(fontSize: Dimensions.fontDefault,color: MyColor.colorBlack)),
                                ],
                            ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 3,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(MyStrings.trxId,style: mulishRegular.copyWith(color: MyColor.hintTextColor),),
                                const SizedBox(height: 2,),
                                Text("${controller.withdrawList[index].trx}",style: robotoBold.copyWith(color: MyColor.textColor,fontSize: Dimensions.fontSmall),)
                              ],
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Divider(height: 1,color: MyColor.borderColor,),
                    const SizedBox(height: 8,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(MyStrings.more,style: mulishRegular,),
                        CircleButtonWithIcon(
                          padding: 5,
                          circleSize: 25,
                          imageSize: 20,
                          bg: MyColor.bgColor1,
                          iconSize: 20,
                          iconColor: MyColor.colorBlack,
                          isIcon: true,
                            icon: currentIndex==index?Icons.expand_less:Icons.expand_more,
                            press: (){
                            if(currentIndex==index){
                              changeExpandIndex(-1);
                            }else{
                              changeExpandIndex(index);
                            }

                        })
                      ],
                    ),
                    currentIndex==index?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        CustomRow(firstText: MyStrings.time, lastText: '${DateConverter.isoStringToLocalDateOnly(controller.withdrawList[index].createdAt??'')}, ${DateConverter.isoStringToLocalTimeOnly(controller.withdrawList[index].createdAt??'')}',showDivider: true,),
                        CustomRow(firstText: MyStrings.charge , lastText: "${controller.withdrawList[index].charge} ${controller.cryptoName}"),
                        CustomRow(firstText: MyStrings.afterCharge,lastText:  "${controller.getAfterCharge(double.tryParse(controller.withdrawList[index].amount.toString()),double.tryParse(controller.withdrawList[index].charge.toString()))}${controller.cryptoName}"),
                        CustomRow(firstText:MyStrings.status, lastText: controller.getStatus(controller.withdrawList[index].status.toString()),isStatus: true,showDivider: controller.withdrawList[index].status.toString()=='3'?true:false,statusTextColor:controller.getStatusColor(controller.withdrawList[index].status.toString()) ,),
                        controller.withdrawList[index].status=='3'?  CustomRow(firstText:MyStrings.aboutTransaction,lastText: "${controller.withdrawList[index].adminFeedback}",isAbout: true,):const SizedBox()
                      ],
                    ) : const SizedBox.shrink()
                  ],
                ),
              );
            })
        ),
      ));


  }


}
