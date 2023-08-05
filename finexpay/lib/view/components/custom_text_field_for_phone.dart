
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_coin/constants/my_strings.dart';
import '../../../../core/utils/my_color.dart';
import '../../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';



class CustomTextFieldForPhone extends StatefulWidget {
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
  final VoidCallback? onSuffixTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool isSearch;
  final VoidCallback? onSubmit;
  final bool isEnabled;
  final TextCapitalization capitalization;
  final bool withSuffix;

  const CustomTextFieldForPhone(
      {Key? key, this.hintText = '${MyStrings.writeSomething}...',
        this.controller,
        this.focusNode,
        this.nextFocus,
        this.isEnabled = true,
        this.inputType = TextInputType.text,
        this.inputAction = TextInputAction.next,
        this.maxLines = 1,
        this.onSuffixTap,
        this.fillColor=MyColor.colorWhite,
        this.onSubmit,
        this.withSuffix=false,
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
        this.isSearch = false,}) : super(key: key);

  @override
  State<CustomTextFieldForPhone> createState() => _CustomTextFieldForPhoneState();
}

class _CustomTextFieldForPhoneState extends State<CustomTextFieldForPhone> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: robotoRegular.copyWith(color: MyColor.textColor, fontSize: Dimensions.fontLarge),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[0-9+]'))] : null,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
        border:  OutlineInputBorder(
          borderRadius:widget.withSuffix?BorderRadius.only(topLeft: Radius.circular(Dimensions.textFieldRadius),bottomLeft:Radius.circular(Dimensions.textFieldRadius)): BorderRadius.only(topRight: Radius.circular(Dimensions.textFieldRadius),bottomRight:Radius.circular(Dimensions.textFieldRadius)),
          borderSide:  BorderSide(color: MyColor.borderColor, width: 0.5),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius:widget.withSuffix?BorderRadius.only(topLeft: Radius.circular(Dimensions.textFieldRadius),bottomLeft:Radius.circular(Dimensions.textFieldRadius)): BorderRadius.only(topRight: Radius.circular(Dimensions.textFieldRadius),bottomRight:Radius.circular(Dimensions.textFieldRadius)),
          borderSide:  BorderSide(color: MyColor.borderColor, width: 0.5),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius:widget.withSuffix?BorderRadius.only(topLeft: Radius.circular(Dimensions.textFieldRadius),bottomLeft:Radius.circular(Dimensions.textFieldRadius)): BorderRadius.only(topRight: Radius.circular(Dimensions.textFieldRadius),bottomRight:Radius.circular(Dimensions.textFieldRadius)),
          borderSide: BorderSide(color: MyColor.primaryColor, width: 0.5),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius:widget.withSuffix?BorderRadius.only(topLeft: Radius.circular(Dimensions.textFieldRadius),bottomLeft:Radius.circular(Dimensions.textFieldRadius)): BorderRadius.only(topRight: Radius.circular(Dimensions.textFieldRadius),bottomRight:Radius.circular(Dimensions.textFieldRadius)),
          borderSide:  BorderSide(color: MyColor.red, width: 0.5),
        ),
        focusedErrorBorder:  OutlineInputBorder(
          borderRadius:widget.withSuffix?BorderRadius.only(topLeft: Radius.circular(Dimensions.textFieldRadius),bottomLeft:Radius.circular(Dimensions.textFieldRadius)): BorderRadius.only(topRight: Radius.circular(8),bottomRight:Radius.circular(8)),
          borderSide: BorderSide(color: Colors.red, width: 0.5),
        ),
        isDense: true,
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        hintStyle: mulishRegular.copyWith(fontSize: Dimensions.fontDefault, color: MyColor.colorGrey),
        filled: true,
        prefixIcon: widget.isShowPrefixIcon ? Padding(
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
          // child: Image.asset(widget.prefixIconUrl),
          child: Image.asset(""),
        ) : const SizedBox.shrink(),
        prefixIconConstraints:const  BoxConstraints(minWidth: 23, maxHeight: 20),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
            ? IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: MyColor.hintTextColor2),
            onPressed: _toggle)
            : widget.isIcon
            ? IconButton(
          onPressed: widget.onSuffixTap,
          icon: const Icon(
            Icons.expand_more_outlined,
            size: 25,
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
