import 'package:flutter/material.dart';

class RadiusContainer extends StatelessWidget {
  const RadiusContainer({
    Key key,
    this.width,
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
    this.child,
  }) : super(key: key);

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

  final Widget child;

  Widget buildChild(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("radius:"+radius.toString()+";borderWidth:"+borderWidth.toString());
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0),
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
        child: child ?? buildChild(context));
  }
}
