import 'package:flutter/material.dart';
import 'package:flutter_learn/widget/radius_container.dart';

///自定义输入框
class RadiusEditText extends RadiusContainer {
  const RadiusEditText(
      {Key key,
      double width,
      double height,
      Color backgroundColor,
      Color borderColor,
      double borderWidth,
      double radius =40,
      double radiusTopLeft,
      double radiusTopRight,
      double radiusBottomLeft,
      double radiusBottomRight,
      double margin,
      double marginLeft,
      double marginTop,
      double marginRight,
      double marginBottom,
      double padding,
      double paddingLeft,
      double paddingTop,
      double paddingRight,
      double paddingBottom,
      this.textColor,
      this.textSize: 14,
      this.textStyle,
      this.textInputAction,
      this.textAlign,
      this.focusNode,
      this.keyboardType,
      this.obscureText = false,
      this.hintText,
      this.icon,
      this.controller,
      this.onSubmitted})
      : super(
          key: key,
          width: width,
          height: height,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
          radius: radius,
          radiusTopLeft: radiusTopLeft,
          radiusTopRight: radiusTopRight,
          radiusBottomLeft: radiusBottomLeft,
          radiusBottomRight: radiusBottomRight,
          margin: margin,
          marginLeft: marginLeft,
          marginTop: marginTop,
          marginRight: marginRight,
          marginBottom: marginBottom,
          padding: padding,
          paddingLeft: paddingLeft,
          paddingTop: paddingTop,
          paddingRight: paddingRight,
          paddingBottom: paddingBottom,
        );

  //文本颜色
  final Color textColor;

  //文本大小
  final double textSize;

  //文本样式-当该属性存在以上属性失效
  final TextStyle textStyle;

  //键盘action模式
  final TextInputAction textInputAction;

  //文本对齐方式
  final TextAlign textAlign;

  final FocusNode focusNode;

  //键盘模式
  final TextInputType keyboardType;

  //是否密码模式
  final bool obscureText;

  //  提示文字
  final String hintText;

  // 图标icon
  final Widget icon;

  //文本控制
  final TextEditingController controller;

  //action 输入完成
  final ValueChanged<String> onSubmitted;
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
  @override
  Widget buildChild(BuildContext context) {
    return TextField(
      textAlign: textAlign ?? TextAlign.left,
      cursorColor: textColor ?? Theme.of(context).cursorColor,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      maxLengthEnforced: true,
      textInputAction: textInputAction,
      style: textStyle != null
          ? textStyle
          : TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
      decoration: InputDecoration(
          focusColor: Colors.transparent,
          hintText: hintText,
          icon: icon,
          //去掉下划线
          border: InputBorder.none),
    );
  }
}
