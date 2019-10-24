import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/util/toast_util.dart';

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
        onTap: () {},
      ),
      Text("和"),
      GestureDetector(
        child: Text(
          "《隐私协议》",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onTap: () {},
      ),
    ]);
  } //维护复选框状态
}

class RegisterLogin extends StatelessWidget {
  final GestureTapCallback onPressed;

  const RegisterLogin({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TapGestureRecognizer recognizer = TapGestureRecognizer();
    recognizer.onTap = () {
      ToastUtil.show("sss");
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
