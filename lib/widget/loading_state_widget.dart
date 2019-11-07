import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///加载中状态控件
class LoadingStateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: Theme.of(context).hintColor.withOpacity(0.5),
          padding: EdgeInsets.all(20),
          child: CupertinoActivityIndicator(
            radius: 12,
          ),
        ),
      ),
    );
  }
}
