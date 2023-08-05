import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';

class KeyPadButtonConfig {
  const KeyPadButtonConfig({
    double? size,
    double? fontSize,
    double? actionFontSize,
    this.foregroundColor=MyColor.colorBlack,
    this.backgroundColor=MyColor.colorWhite,
    this.buttonStyle,
  })  : size = size ?? 68,
        fontSize = fontSize ?? 36;

  final double size;
  final double fontSize;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final ButtonStyle? buttonStyle;

  ButtonStyle toButtonStyle() {
    ButtonStyle composed = OutlinedButton.styleFrom(
      textStyle: TextStyle(
        fontSize: fontSize,
        overflow: TextOverflow.fade,
        color: MyColor.colorBlack
      ),
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    );
    if (buttonStyle != null) {
      return buttonStyle!.copyWith(
        textStyle: composed.textStyle,
        foregroundColor: composed.foregroundColor,
        backgroundColor: composed.backgroundColor,
      );
    } else {
      return composed;
    }
  }

  KeyPadButtonConfig copyWith({
    double? size,
    double? fontSize,
    Color? foregroundColor,
    Color? backgroundColor,
    ButtonStyle? buttonStyle,
  }) {
    return KeyPadButtonConfig(
      size: size ?? this.size,
      fontSize: fontSize ?? this.fontSize,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }
}
