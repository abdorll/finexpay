import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';


class ChooseFileItem extends StatelessWidget {
  final String fileName;
  const ChooseFileItem({Key? key,required this.fileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          color: MyColor.transparentColor,
          border: Border.all(color: MyColor.colorGrey, width: 0.5),
          borderRadius: BorderRadius.circular(Dimensions.radius)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(color: MyColor.colorBlack.withOpacity(0.04), borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            child: Text(MyStrings.chooseFile.tr, textAlign: TextAlign.center, style: mulishRegular.copyWith(color: MyColor.primaryColor, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 15,),
          Expanded(
            flex: 5,
            child: TextField(
              readOnly: true,
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: fileName.tr),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(bottom: 16),
                  hintText: fileName.tr,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none
              ),
            ),
          ),

        ],
      ),
    );
  }
}
