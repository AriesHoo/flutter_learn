import 'package:flutter/material.dart';
import 'package:flutter_learn/hepler/image_helper.dart';

class ThirdLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: theme.hintColor.withAlpha(50),
              height: 0.6,
              width: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("微信登录",
                  style: TextStyle(color: theme.hintColor)),
            ),
            Container(
              color: theme.hintColor.withAlpha(50),
              height: 0.6,
              width: 60,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                },
                child: Image.asset(
                  ImageHelper.wrapAssets(ImageHelper.IMAGE_TYPE_START,'ic_we_chat_login.png'),
                  width: 40,
                  height: 40,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}