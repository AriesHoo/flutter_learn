import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/hepler/image_helper.dart';
import 'package:flutter_learn/hepler/toast_util.dart';
import 'package:flutter_learn/module/start/third_login.dart';
import 'package:flutter_learn/widget/button.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
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
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
              ImageHelper.wrapAssets(
                  ImageHelper.IMAGE_TYPE_START, "ic_launcher_round.png"),
              width: 60,
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: "请输入账号名",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 3.0,
                            style: BorderStyle.solid) //没什么卵效果
                        )),
              ),
            ),
            RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.blue,
              child: Container(
                height: 48,
                alignment: Alignment.center,
                child: Text(
                  "登录",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              onPressed: () {
              },
            ),
            Button(
              "登录",
              onPressed: () {
                ToastUtil.show("登录");
              },
            ),
            Expanded(
              flex: 1,
              child: new Container(),
            ),
            ThirdLogin(),
          ],
        ),
      ),
    );
  }
}
