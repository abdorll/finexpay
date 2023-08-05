import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';


import '../../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class CustomTextField extends StatefulWidget {

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final Color? hintColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final VoidCallback? onTap;
  final Function? onChanged;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final IconData? prefixIcon;
  final bool isSearch;
  final bool isDropDown;
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final String? errorText;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final Color enableOutlineColor;
  final double borderWidth;
  final FormFieldValidator? validator;



  const CustomTextField(
      {Key? key,
        this.hintText = '${MyStrings.writeSomething}...',
        this.controller,
        this.validator,
        this.borderWidth=1,
        this.borderRadius=Dimensions.cornerRadius,
        this.focusNode,
        this.nextFocus,
        this.hintColor=MyColor.hintTextColor,
        this.isDropDown=false,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSuffixTap,
        this.fillColor=MyColor.bgColor1,
        this.onSubmit,
        required this.onChanged,
        this.capitalization = TextCapitalization.none,
        this.isCountryPicker = false,
        this.isShowBorder = false,
        this.isShowSuffixIcon = false,
        this.isShowPrefixIcon = false,
        this.onTap,
        this.isIcon = false,
        this.isPassword = false,
        this.suffixIconUrl,
        this.prefixIcon,
        this.errorText,
        this.verticalPadding=16,
        this.horizontalPadding=22,
        this.enableOutlineColor=MyColor.borderColor,
        this.isSearch = false,}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.fillColor,
        borderRadius:  BorderRadius.circular(6),
      ),
      child: TextFormField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: mulishRegular.copyWith(color: MyColor.textColor, fontSize: Dimensions.fontLarge),
        textInputAction: widget.inputAction,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).primaryColor,
        textCapitalization: widget.capitalization,
        enabled: widget.isEnabled,
        validator: widget.validator,
        autofocus: false,
        obscureText: widget.isPassword ? _obscureText : false,
        inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
        decoration: InputDecoration(
          contentPadding:  EdgeInsets.symmetric(vertical: widget.verticalPadding, horizontal: widget.horizontalPadding),
          disabledBorder:   OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
            borderSide: BorderSide(width: widget.borderWidth,color:MyColor.borderColor),
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
            borderSide: BorderSide(width: widget.borderWidth,color:MyColor.primaryColor),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadius)),
            borderSide: BorderSide(width: widget.borderWidth,color:widget.enableOutlineColor),
          ),
          errorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide:  BorderSide(width: widget.borderWidth,color: Colors.red)
          ),
          focusedErrorBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide:  BorderSide(width: widget.borderWidth,color: Colors.red)
          ),
          isDense: true,
          hintText: widget.hintText.tr,
          fillColor: widget.fillColor?.withOpacity(0.03),
          hintStyle: mulishRegular.copyWith(fontSize: Dimensions.fontDefault, color: widget.hintColor),
          filled: true,
          prefixIcon: widget.isShowPrefixIcon ? Padding(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
            child: Icon(widget.prefixIcon,color: MyColor.colorWhite,),
          ) : const SizedBox.shrink(),
          prefixIconConstraints:const  BoxConstraints(minWidth: 23, maxHeight: 20),
          suffixIcon: widget.isShowSuffixIcon
              ? widget.isPassword
              ? IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor),
              onPressed: _toggle)
              : widget.isIcon
              ? IconButton(
            onPressed: widget.onSuffixTap,
            icon:  Icon(
              widget.isSearch?Icons.search_outlined:widget.isDropDown?Icons.arrow_drop_down_sharp:Icons.expand_more,
              size: 25,
              color: widget.hintColor,
            ),
          )
              : null
              : null,
        ),
        onTap: widget.onTap,
        onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
            : widget.onSubmit != null ? widget.onSubmit!() : null,
        onChanged: (text)=> widget.onChanged!(text),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
