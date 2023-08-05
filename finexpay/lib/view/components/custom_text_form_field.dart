import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';

import '../../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';

class CustomTextFormField extends StatefulWidget {

  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final Color? fillColor;
  final int maxLines;
  final bool isPassword;
  final bool isCountryPicker;
  final bool isShowBorder;
  final bool isIcon;
  final bool isShowSuffixIcon;
  final bool isShowPrefixIcon;
  final VoidCallback? onTap;
  final Function onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final String? errorText;
  final bool isUnderline;
  final String label;
  final bool readOnly;
  final Color disableColor;


  const CustomTextFormField(
      {Key? key, this.hintText = '${MyStrings.writeSomething}...',
        this.controller,
        this.focusNode,
        this.readOnly = false,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSuffixTap,
        this.validator,
        this.fillColor=MyColor.bgColorLight,
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
        this.prefixIconUrl,
        this.errorText,
        this.isUnderline = false,
        this.label = '',
        this.disableColor =  MyColor.borderColor,
        this.isSearch = false,}) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.isUnderline?TextFormField(
      readOnly: widget.readOnly,
      style: mulishRegular.copyWith(color: MyColor.colorBlack),
     // textAlign: widget.readOnly?TextAlign.center:TextAlign.left,
      cursorColor: MyColor.primaryColor,
      controller: widget.controller,
      autofocus: false,
      textInputAction: widget.inputAction,
      enabled: widget.isEnabled,
      focusNode: widget.focusNode,
      validator: widget.validator,
      keyboardType: widget.inputType,
      obscureText: widget.isPassword?_obscureText:false,
      decoration: InputDecoration(
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
        labelText:  widget.label.tr,
        labelStyle: mulishRegular.copyWith(color: MyColor.colorBlack2),
        hintStyle: mulishRegular.copyWith(color: MyColor.hintTextColor),
        fillColor: MyColor.transparentColor,
        filled: true,
        border: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.borderColor)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.primaryColor)),
        disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: widget.disableColor)),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: MyColor.borderColor)),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
            ? IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor, size: 16),
            onPressed: _toggle)
            : widget.isIcon
            ? IconButton(
          onPressed: widget.onSuffixTap,
          icon:  Icon(
            widget.isSearch ? Icons.search_outlined : widget.isCountryPicker ? Icons.arrow_drop_down_outlined:Icons.camera_alt_outlined,
            size: 25,
            color: MyColor.primaryColor,
          ),
        )
            : null
            : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) :null,
      onChanged: (text)=> widget.onChanged(text),
    ):TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: robotoRegular.copyWith(color: MyColor.textColor, fontSize: Dimensions.fontLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      validator:widget.validator,
      autofocus: false,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          borderSide: const BorderSide(color: MyColor.borderColor, width: 0.5),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          borderSide: const BorderSide(color: MyColor.borderColor, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          borderSide: const BorderSide(color: MyColor.primaryColor, width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          borderSide: const BorderSide(color: Colors.red, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          borderSide: const BorderSide(color: MyColor.primaryColor, width: 0.5),
        ),
        disabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.textFieldRadius),
          borderSide: const BorderSide(color: MyColor.borderColor, width: 0.5),
        ) ,
        isDense: true,
        hintText: widget.hintText.tr,
        fillColor: widget.fillColor,
        hintStyle: mulishRegular.copyWith(fontSize: Dimensions.fontDefault, color: MyColor.colorGrey),
        filled: true,
        prefixIcon: widget.isShowPrefixIcon ? Padding(
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
          child: Icon(widget.isPassword?Icons.lock_outline:Icons.email_outlined,color: MyColor.hintTextColor,),
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
            widget.isSearch?Icons.search_outlined:widget.isCountryPicker?Icons.arrow_drop_down_outlined:Icons.camera_alt_outlined,
            size: 25,
            color: MyColor.primaryColor,
          ),
        )
            : null
            : null,
      ),
      onTap: widget.onTap,
      onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null ? widget.onSubmit!() : null,
      onChanged: (text)=> widget.onChanged(text),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}