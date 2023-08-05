import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/core/utils/dimensions.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/core/utils/styles.dart';


class NoDataWidget extends StatelessWidget {
  final double topMargin;
  final double bottomMargin;
  final String title;
  final double imageHeight;
  const NoDataWidget({Key? key,
    this.topMargin = 0,
    this.title = MyStrings.noData,
    this.imageHeight = 130,
    this.bottomMargin = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top:topMargin,bottom: bottomMargin),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          decoration: BoxDecoration(
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.cornerRadius)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: imageHeight,
                child: SvgPicture.asset(MyImages.noDataImage,height: imageHeight,width: 200,color: MyColor.colorHint,),
              ),
              const SizedBox(height: 20,),
              Text(
                title.tr,
                textAlign: TextAlign.center,
                style: mulishRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontDefault),
              )
            ],
          ),
        ),
      ),
    );
  }
}
