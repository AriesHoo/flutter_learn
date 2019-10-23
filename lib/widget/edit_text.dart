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
      this.borderRadius})
      : super(key: key);

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
        decoration: InputDecoration(
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            hintText: hintText,
            //去掉下划线
            icon: icon,
            focusColor: Theme.of(context).accentColor,
            border: InputBorder.none),
      ),
    );
  }
}
