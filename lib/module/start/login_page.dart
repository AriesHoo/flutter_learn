import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/util/image_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/module/start/third_login.dart';
import 'package:flutter_learn/widget/button.dart';
import 'package:flutter_learn/widget/edit_text.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('登录'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new Container(),
            ),
            Image.asset(
              ImageUtil.wrapAssets(
                  ImageUtil.IMAGE_TYPE_START, "ic_launcher_round.png"),
              width: 80,
              height: 80,
            ),
            Expanded(
              flex: 1,
              child: new Container(),
            ),
            EditText(
              hintText: "请输入账号",
              keyboardType: TextInputType.phone,
              icon: Icon(
                Icons.person_outline,
                color: Theme.of(context).accentColor,
              ),
            ),
            EditText(
              margin: EdgeInsets.only(bottom: 20),
              hintText: "请输入密码",
              obscureText: true,
              keyboardType: TextInputType.text,
              icon: Icon(Icons.lock_outline,
                  color: Theme.of(context).accentColor),
            ),
            Button(
              "登录",
              borderRadius: 10,
              onPressed: () {
                ToastUtil.show("登录");
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child: Text("忘记密码"),
                  onPressed: () {
                    ToastUtil.show("忘记密码");
                  },
                ),
                Text("快速注册"),
              ],
            ),
            Expanded(
              flex: 2,
              child: new Container(),
            ),
            ThirdLogin(),
          ],
        ),
      ),
    );
  }
}
