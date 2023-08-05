import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';

class CustomDropDownTextField extends StatefulWidget {
  final String? title, selectedValue;
  final List<String>? list;
  final ValueChanged? onChanged;
  final double paddingLeft;
  final double titleSpace;
  final double paddingRight;
  final bool isShowTittle;
  const CustomDropDownTextField({Key? key, this.isShowTittle=true,this.titleSpace=10,this.title,this.paddingLeft=10,this.paddingRight=10, this.selectedValue, this.list, this.onChanged, }) : super(key: key);

  @override
  State<CustomDropDownTextField> createState() => _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isShowTittle?Text((widget.title??"").tr,style: mulishRegular,):const SizedBox(),
        widget.isShowTittle?SizedBox(height: widget.titleSpace,):const SizedBox(),
        Container(
          decoration: BoxDecoration(
              color: MyColor.textFieldColor,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(
                  color:  MyColor.borderColor
              )
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.paddingLeft,
                right: widget.paddingRight
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(),
              hint: Text(
                (widget.selectedValue??'').tr,
                style: mulishRegular.copyWith(fontSize: Dimensions.fontExtraSmall),
              ),
              value: widget.selectedValue,
              dropdownColor: MyColor.colorWhite,
              iconEnabledColor: MyColor.primaryColor,
              onChanged: widget.onChanged,
              items: widget.list!.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.tr,
                    style: mulishLight.copyWith(color: MyColor.textColor),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
