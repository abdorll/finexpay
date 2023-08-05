
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/string_format_helper.dart';
import 'package:local_coin/core/utils/my_icons.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';

import '../../../../../core/route/route.dart';
import '../../../../../core/utils/dimensions.dart';
import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../data/model/wallet/main_wallet_response_model/MainWalletResponseModel.dart';
import '../../../../components/buttons/category_button.dart';

class WalletListWidget extends StatelessWidget {
  final Wallets wallet;
  final String imagePath;
  final String depositCharge;

  const WalletListWidget(
      {Key? key, required this.depositCharge,required this.wallet, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 15),
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
                child: Row(
                  children: [
                    CircleButtonWithIcon(
                      isIcon: false,
                      isAsset: false,
                      imagePath:
                          '${UrlContainer.baseUrl}$imagePath/${wallet.crypto?.image}',
                      circleSize: 33,
                      imageSize: 33,
                      padding: 0,
                      press: (){},
                      bg: MyColor.transparentColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wallet.crypto?.name ?? '',
                            style: mulishRegular,
                          ),
                          const SizedBox(height: 2,),
                              Text("${CustomValueConverter.twoDecimalPlaceFixedWithoutRounding(wallet.balance??'0')} ${wallet.crypto?.code}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontDefault, color: MyColor.colorBlack)),
                           
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(MyStrings.depositCharge.tr,
                      style: mulishLight.copyWith(
                          color: MyColor.textColor,
                          fontSize: Dimensions.fontSmall),
                      textAlign: TextAlign.end,
                    ),
                    Text(
                       depositCharge,
                        style: mulishRegular.copyWith(
                            fontSize: Dimensions.fontSmall)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: MyColor.borderColor,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.bgColor1),
                child: TextButton.icon(
                    style:ButtonStyle(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0))),

                  onPressed: () {
                    Get.toNamed(RouteHelper.singleWalletTransaction,arguments: wallet.crypto?.id.toString());
                  },
                  icon:  SvgPicture.asset(
                    MyIcons.transferNewIcon,
                    color: MyColor.textColor,
                    height: 18,width: 18,
                  ),
                  label:Text(
                    MyStrings.transactions.tr,
                    style: mulishRegular,
                  ),
                )
                ,
              ),
              const Spacer(),
              CategoryButton(
                horizontalPadding: 8,
                textSize: Dimensions.fontDefault,
                text: MyStrings.deposit,
                press: () {
                  Get.toNamed(RouteHelper.walletAddressScreen,
                      arguments: [int.tryParse(wallet.cryptoId ?? '0'),wallet.crypto?.code??'']);
                },
                color: MyColor.secondaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              CategoryButton(
                color: MyColor.primaryColor,
                  horizontalPadding: 8,
                  textSize: Dimensions.fontDefault,
                  text: MyStrings.withdraw,
                  press: () {
                    Get.toNamed(RouteHelper.addWithdrawScreen,
                        arguments: [int.tryParse(wallet.cryptoId ?? '-1'),wallet.crypto?.code??'']);
                  }),
            ],
          ),
        ],
      ),
    );
  }


}
