import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/util/toast_util.dart';

///注册声明
class LoginCopyright extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onChanged;

  const LoginCopyright({
    Key key,
    this.checked,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Checkbox(
        value: checked,
        onChanged: onChanged,
      ),
      Text("我已阅读"),
      GestureDetector(
        child: Text(
          "《注册协议》",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onTap: () {
          ToastUtil.show("注册协议");
        },
      ),
      Text("和"),
      GestureDetector(
        child: Text(
          "《隐私协议》",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onTap: () {
          ToastUtil.show("隐私协议");
        },
      ),
    ]);
  } //维护复选框状态
}

///注册页提示返回登录功能
class RegisterLogin extends StatelessWidget {
  final GestureTapCallback onPressed;

  const RegisterLogin({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TapGestureRecognizer recognizer = TapGestureRecognizer();
    recognizer.onTap = (){
      Navigator.of(context).pop();
    };
    return Center(
      child: Text.rich(TextSpan(text: "已有账号？", children: [
        TextSpan(
          text: "登录",
          style: TextStyle(color: Theme.of(context).accentColor),
          recognizer: recognizer,
        )
      ])),
    );
  }
}
