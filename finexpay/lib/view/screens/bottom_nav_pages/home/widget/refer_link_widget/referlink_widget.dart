import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/styles.dart';
import 'package:local_coin/data/controller/home/home_controller.dart';
import 'package:local_coin/view/components/buttons/circle_button_with_icon.dart';
import 'package:local_coin/view/components/show_custom_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ReferLinkWidget extends StatelessWidget {
  const ReferLinkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller)=> Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: MyColor.borderColor, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleButtonWithIcon(
                    press: () {},
                    iconColor: MyColor.primaryColor,
                    bg: MyColor.transparentColor,
                    borderColor: MyColor.transparentColor,
                    circleSize: 20,
                    iconSize: 20,
                    icon: Icons.attach_file_rounded,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                Text(
                    MyStrings.referralLink.tr,
                    style: mulishSemiBold,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.cornerRadius),
              border: Border.all(width: 1,color: MyColor.borderColor)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Expanded(child: SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Text(
                    '${controller.referLink}',
                    style: mulishRegular,
                   maxLines: 1,
                  ),
               ),),
                const SizedBox(width: 10,),
                InkWell(
                  splashColor: MyColor.bgColor1,
                  onTap: (){
                    Clipboard.setData(ClipboardData(text: '${controller.referLink}'));
                    CustomSnackbar.showCustomSnackbar(errorList: [], msg: [MyStrings.referralLinkCopied], isError: false);
                  },
                    child: const Icon(Icons.copy,color: MyColor.textColor,size: 18,)),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DottedBorder(
              color: MyColor.borderColor,
              strokeWidth: 1,
              dashPattern: const [5,3],
              radius: const Radius.circular(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton.icon(
                        onPressed: () async{
                          final box = context.findRenderObject() as RenderBox?;
                          await Share.share(controller.referLink??'',
                              subject: '',
                              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
                        },
                        icon: const Icon(Icons.share,color: MyColor.primaryColor,),
                        label:  Text(
                          " ${MyStrings.share.tr}",
                          style: mulishSemiBold,
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    ));
  }
}
