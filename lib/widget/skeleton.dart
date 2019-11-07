import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///占位方块控件
class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final bool isCircle;
  final BorderRadiusGeometry borderRadius;

  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  SkeletonBox({
    @required this.width,
    @required this.height,
    this.isCircle: false,
    this.borderRadius,
    this.margin: const EdgeInsets.all(0),
    this.padding: const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Divider.createBorderSide(context, width: 0.7);
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: SkeletonDecoration(
        isCircle: isCircle,
        isDark: isDark,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// 骨架屏元素 ->形状及颜色及圆角
class SkeletonDecoration extends BoxDecoration {
  SkeletonDecoration({
    isCircle: false,
    isDark: false,

    ///圆角
    BorderRadiusGeometry borderRadius,
  }) : super(
          color: !isDark ? Colors.grey[350] : Colors.grey[700],
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        );
}

/// 骨架屏ListView
class SkeletonList extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool horizontal;
  final int length;
  final IndexedWidgetBuilder builder;

  SkeletonList({
    @required this.builder,
    this.length: 10,
    this.horizontal: false,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Shimmer.fromColors(
        period: Duration(milliseconds: 1000),
        baseColor: isDark ? Colors.grey[700] : Colors.grey[400],
        highlightColor: isDark ? Colors.grey[500] : Colors.grey[200],
        child: Padding(
            padding: padding,
            child: horizontal
                ? Row(
                    children: List.generate(
                        length, (index) => builder(context, index)),
                  )
                : Column(
                    children: List.generate(
                        length, (index) => builder(context, index)),
                  )),
      ),
    );
  }
}
