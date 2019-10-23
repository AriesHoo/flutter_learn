import 'package:flutter/material.dart';

//自定义输入框
class EditText extends StatelessWidget {
  const EditText(
      {Key key,
      this.hintText,
      this.icon,
      this.contentPadding,
      this.margin,
      this.padding,
      this.border,
      this.borderRadius,
      this.obscureText: false,
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.textColor,
      this.textSize:14})
      : super(key: key);
  final TextEditingController controller;

  //文本颜色
  final Color textColor;

  //文本大小
  final double textSize;

  //键盘action模式
  final TextInputAction textInputAction;

  //键盘模式
  final TextInputType keyboardType;

  //是否密码模式
  final bool obscureText;

  //  提示文字
  final String hintText;

  // 图标icon
  final Widget icon;

  //内边距
  final EdgeInsetsGeometry contentPadding;

  //外边距
  final EdgeInsetsGeometry margin;

  //内边距
  final EdgeInsetsGeometry padding;

  //边框线颜色及宽度
  final BoxBorder border;

  //原件样式
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border ??
            Border.all(
                color: Theme.of(context).accentColor, width: 1), // 边色与边宽度
        borderRadius: borderRadius ?? BorderRadius.circular(100), // 也可控件一边圆角大小
      ),
      margin: margin ?? EdgeInsets.symmetric(vertical: 30),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        cursorColor: textColor,
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: TextStyle(
          color: textColor,
          fontSize: textSize,
        ),
        decoration: InputDecoration(
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            hintText: hintText,
            icon: icon,
            //去掉下划线
            border: InputBorder.none),
      ),
    );
  }
}
