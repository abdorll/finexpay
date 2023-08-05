import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/styles.dart';

import '../../../../../../core/utils/my_color.dart';


class CountryTextField extends StatelessWidget {

  final String text;
  final VoidCallback press;

  const CountryTextField({Key? key,
    required this.text,
    required this.press
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: MyColor.transparentColor,
          border: const Border(bottom:BorderSide(color: MyColor.borderColor))
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text(text,style: mulishRegular.copyWith(color: MyColor.colorBlack),),
              const Icon(Icons.expand_more_rounded,color: MyColor.hintTextColor,size: 20,)
            ],
          ),
      ),
    );
  }
}
