import 'package:flutter/material.dart';

//自定义输入框
class EditText extends StatelessWidget {
  const EditText(
      {Key key,
      this.width: double.infinity,
      this.height,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.radius,
      this.radiusTopLeft,
      this.radiusTopRight,
      this.radiusBottomLeft,
      this.radiusBottomRight,
      this.margin,
      this.marginLeft,
      this.marginTop,
      this.marginRight,
      this.marginBottom,
      this.padding,
      this.paddingLeft,
      this.paddingTop,
      this.paddingRight,
      this.paddingBottom,
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
      : super(key: key);

  //控件宽
  final double width;

  //控件高
  final double height;

  //背景色
  final Color backgroundColor;

  //边框线颜色
  final Color borderColor;

  //边框线
  final double borderWidth;

  //圆角样式-全
  final double radius;

  //圆角样式-上左
  final double radiusTopLeft;

  //圆角样式-上右
  final double radiusTopRight;

  //圆角样式-下左
  final double radiusBottomLeft;

  //圆角样式-下右
  final double radiusBottomRight;

  //外边距-上下左右
  final double margin;

  //外边距-左
  final double marginLeft;

  //外边距-上
  final double marginTop;

  //外边距-右
  final double marginRight;

  //外边距-下
  final double marginBottom;

  //内边距-全部
  final double padding;

  //内边距-左
  final double paddingLeft;

  //内边距-上
  final double paddingTop;

  //内边距-右
  final double paddingRight;

  //内边距-下
  final double paddingBottom;

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
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
            color: borderColor ?? Theme.of(context).hintColor, width: borderWidth ?? 0),
        // 边色与边宽度-可控件一边圆角大小
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
              radiusTopLeft != null ? radiusTopLeft : radius ?? 0),
          topRight: Radius.circular(
              radiusTopRight != null ? radiusTopRight : radius ?? 0),
          bottomLeft: Radius.circular(
              radiusBottomLeft != null ? radiusBottomLeft : radius ?? 0),
          bottomRight: Radius.circular(
              radiusBottomRight != null ? radiusBottomRight : radius ?? 0),
        ),
      ),
      margin: EdgeInsets.only(
        left: marginLeft != null ? marginLeft : margin ?? 0,
        top: marginTop != null ? marginTop : margin ?? 0,
        right: marginRight != null ? marginRight : margin ?? 0,
        bottom: marginBottom != null ? marginBottom : margin ?? 0,
      ),
      padding: EdgeInsets.only(
        left: paddingLeft != null ? paddingLeft : padding ?? 0,
        top: paddingTop != null ? paddingTop : padding ?? 0,
        right: paddingRight != null ? paddingRight : padding ?? 0,
        bottom: paddingBottom != null ? paddingBottom : padding ?? 0,
      ),
      child: TextField(
        textAlign: textAlign ?? TextAlign.left,
        cursorColor: textColor,
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
      ),
    );
  }
}
