import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/helper/date_converter.dart';
import 'package:local_coin/data/model/wallet/single_wallet_address_response_model/SingleWalletResponseModel.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';

import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/styles.dart';

class WalletAddressListItem extends StatelessWidget {
  final Data model;
  final String? cryptoImagePath;

  const WalletAddressListItem(
      {Key? key, required this.model, this.cryptoImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: MyColor.borderColor)),
      child: Row(
        children: [
          CircleButtonWithIcon(
            imagePath: cryptoImagePath ?? '',
            press: () {},
            isAsset: false,
            circleSize: 28,
            padding: 0,
            isIcon: false,
            imageSize: 28,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.walletAddress}",
                  style: mulishRegular.copyWith(overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${DateConverter.isoStringToLocalDateOnly(model.createdAt ?? '')}, ${DateConverter.isoStringToLocalTimeOnly(model.createdAt ?? '')}',
                  style: mulishLight.copyWith(color: MyColor.textColor),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: MyColor.transparentColor),
            child: IconButton(
            padding: EdgeInsets.zero,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: model.walletAddress!));
                CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.copied], isError: false);
              },
              icon: const Icon(
                Icons.copy,
                color: MyColor.textColor,
                size: 18,
              ),
            )
            ,
          ),
        ],
      ),
    );
  }


}
