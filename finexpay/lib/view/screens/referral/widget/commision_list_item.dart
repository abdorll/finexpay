import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/model/referral/ReferralCommissionResponseModel.dart';
import 'package:local_coin/view/components/circle_image/circle_image_button.dart';

import '../../../../core/helper/date_converter.dart';
import '../../../../core/helper/string_format_helper.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';

class CommissionListItem extends StatelessWidget {
  final int index;
  final Data model;
  final String imagePath;

  const CommissionListItem(
      {Key? key,
        required this.index,
        required this.imagePath,
        required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
            border: Border.all(color: MyColor.borderColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Row(children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${MyStrings.form.tr} : ${model.bywho?.username??''}",
                        style: mulishRegular,
                      )
                    ])),
                Text('${DateConverter.isoStringToLocalDateOnly(model.createdAt??'')} ${DateConverter.isoStringToLocalTimeOnly(model.createdAt??'')}',style: robotoRegular.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontSmall),),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.bgColor1),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                       CircleImageWidget(imagePath: imagePath,height: 30,width: 30,isAsset: false,press: (){},),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "${model.commissionAmount} ${model.crypto?.code??''}",
                          style: mulishRegular,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${CustomValueConverter.getTrailingExtension(int.tryParse(model.level??'0')??0)} ${MyStrings.level.tr}",
                            style: robotoRegular,
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                          )),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              " ${MyStrings.percent.tr} : ${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(model.percent ?? '0')} %",
              style: robotoRegular,
            ),
          ],
        ),
      ),
    );
  }
}
