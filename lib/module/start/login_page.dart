import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/module/start/login_widget.dart';
import 'package:flutter_learn/util/image_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/module/start/third_login.dart';
import 'package:flutter_learn/widget/button.dart';
import 'package:flutter_learn/widget/edit_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _controllerAccount = new TextEditingController();
  final _controllerPassword = new TextEditingController();
  final _focusNodePassword = new FocusNode();
  bool _checkboxSelected = false; //维护复选框状态
  final TapGestureRecognizer recognizer = TapGestureRecognizer();

  void initState() {
    super.initState();
    recognizer.onTap = () {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Container(
//        color: Colors.red,
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 30),
//        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
              radius: 40,
              borderWidth: 1,
              marginBottom: 30,
              paddingLeft: 20,
              paddingRight: 20,
              controller: _controllerAccount,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              onSubmitted: (s) {
                if (_controllerAccount.text.isEmpty) {
                  ToastUtil.show("请输入账号");
                  return;
                }
                FocusScope.of(context).requestFocus(_focusNodePassword);
              },
            ),
            EditText(
              hintText: "请输入密码",
              radius: 40,
              borderWidth: 1,
              marginBottom: 30,
              paddingLeft: 20,
              paddingRight: 20,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (s) {
                ToastUtil.show("开始登录");
              },
              focusNode: _focusNodePassword,
              controller: _controllerPassword,
              keyboardType: TextInputType.text,
            ),
//            RadiusContainer(
//              radius: 40,
//              borderColor: Theme.of(context).accentColor,
//              borderWidth: 1,
//              marginBottom: 30,
//              padding: 20,
//              paddingRight: 20,
//              child: Text("哈哈哈"),
//            ),
            Button(
              "登录",
              borderRadius: 40,
              onPressed: () {
                ToastUtil.show("登录");
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Text("立即注册"),
                  onTap: () => ToastUtil.show("立即注册"),
                ),
                GestureDetector(
                  child: Text("忘记密码"),
                  onTap: () => ToastUtil.show("忘记密码"),
                ),
              ],
            ),
            LoginCopyright(
              checked: _checkboxSelected,
              onChanged: (checked) {
                setState(() {
                  _checkboxSelected = checked;
                });
              },
            ),
            RegisterLogin(
              onPressed: () {
                ToastUtil.show("onPressed");
                Navigator.of(context).pop();
              },
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
