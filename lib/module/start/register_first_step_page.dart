import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/config/app_config.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/model/web_view_model.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/image_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
import 'package:flutter_learn/widget/button.dart';
import 'package:flutter_learn/widget/edit_text.dart';

/// 注册/忘记密码第一步
class RegisterFirstStepPage extends StatefulWidget {
  const RegisterFirstStepPage({Key key, this.isRegister}) : super(key: key);

  ///是否注册页
  final bool isRegister;

  @override
  _RegisterFirstStepPageState createState() => _RegisterFirstStepPageState();
}

class _RegisterFirstStepPageState extends State<RegisterFirstStepPage> {
  final _controllerAccount = new TextEditingController();
  final _controllerPassword = new TextEditingController();
  final _focusNodePassword = new FocusNode();
  bool _checkboxSelected = false; //维护复选框状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isRegister
            ? S.of(context).register
            : S.of(context).forgetPassword),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 40, right: 40, bottom: 30),
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
              hintText: S.of(context).hintEnterPhone,
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
                  ToastUtil.show(S.of(context).hintEnterPhone);
                  return;
                }
                FocusScope.of(context).requestFocus(_focusNodePassword);
              },
            ),
            EditText(
              hintText: S.of(context).hintEnterCode,
              radius: 40,
              borderWidth: 1,
              marginBottom: 30,
              paddingLeft: 20,
              paddingRight: 20,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (s) {},
              focusNode: _focusNodePassword,
              controller: _controllerPassword,
              keyboardType: TextInputType.text,
            ),
            Button(
              S.of(context).nextStep,
              borderRadius: 40,
              onPressed: () {
                ToastUtil.show(S.of(context).nextStep);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            widget.isRegister
                ? RegisterCopyright(
                    checked: _checkboxSelected,
                    onChanged: (checked) {
                      setState(() {
                        _checkboxSelected = checked;
                      });
                    },
                  )
                : Container(),
            widget.isRegister
                ? Expanded(
                    flex: 2,
                    child: Container(),
                  )
                : Container(),
            widget.isRegister ? RegisterLogin() : Container(),
            Expanded(
              flex: widget.isRegister ? 1 : 5,
              child: new Container(),
            ),
          ],
        ),
      ),
    );
  }
}

///注册声明
class RegisterCopyright extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onChanged;

  const RegisterCopyright({
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
      Text(S.of(context).registerIRead),
      GestureDetector(
        child: Text(
          S.of(context).registerAgreement,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onTap: () => Navigator.of(context).pushNamed(RouteName.webView,
            arguments: WebViewModel.getModel(S.of(context).registerAgreement,
                AppConfig.registerAgreementUrl)),
      ),
      Text(S.of(context).registerAnd),
      GestureDetector(
        child: Text(
          S.of(context).registerPrivacyProtocol,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onTap: () => Navigator.of(context).pushNamed(RouteName.webView,
            arguments: WebViewModel.getModel(
                S.of(context).registerPrivacyProtocol,
                AppConfig.registerPrivacyUrl)),
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
    recognizer.onTap = () {
      Navigator.of(context).pop();
    };
    return Center(
      child:
          Text.rich(TextSpan(text: S.of(context).registerHadAccount, children: [
        TextSpan(
          text: S.of(context).login,
          style: TextStyle(color: Theme.of(context).accentColor),
          recognizer: recognizer,
        )
      ])),
    );
  }
}
