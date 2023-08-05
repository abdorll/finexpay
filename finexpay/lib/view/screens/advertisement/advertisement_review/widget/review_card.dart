import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/advertisement/AdvertisementReviewResponseModel.dart';

import '../../../../../core/helper/date_converter.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_icons.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../components/buttons/circle_button_with_icon.dart';

class ReviewCard extends StatelessWidget {
  final Reviews model;
  const ReviewCard({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool positive=model.type=='0'?false:true;
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
                    Align(
                      alignment: Alignment.topLeft,
                        child: CircleButtonWithIcon(press: (){},circleSize: 40,imageSize: 40,padding: 0,isAsset:false,isIcon: false,imagePath: model.userImage??MyImages.defaultAvatar,)),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text (model.userName??'',overflow: TextOverflow.ellipsis,
                                  style:mulishRegular.copyWith(fontSize: Dimensions.fontLarge,)),),

                              const SizedBox(width: 10,),

                              Text ('${DateConverter.isoStringToLocalDateOnly(model.createdAt??'0')}, ${DateConverter.isoStringToLocalTimeOnly(model.createdAt??'0')}',overflow: TextOverflow.ellipsis,
                                  style:mulishRegular.copyWith(fontStyle:FontStyle.italic,color: MyColor.colorGrey4,fontSize: Dimensions.fontSmall)),


                            ],
                          ),
                          const SizedBox(height: 5,),
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
          Text(model.feedback.toString().tr,style: mulishRegular.copyWith(color: MyColor.textColor),)
        ],
      ),
    );
  }
}
