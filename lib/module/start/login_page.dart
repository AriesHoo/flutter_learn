import 'package:flutter/material.dart';
import 'package:flutter_learn/generated/i18n.dart';
import 'package:flutter_learn/router_manger.dart';
import 'package:flutter_learn/util/image_util.dart';
import 'package:flutter_learn/util/toast_util.dart';
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).login),
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
              hintText: S.of(context).hintEnterAccount,
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
                  ToastUtil.show(S.of(context).hintEnterAccount);
                  return;
                }
                FocusScope.of(context).requestFocus(_focusNodePassword);
              },
            ),
            EditText(
              hintText: S.of(context).hintEnterPassword,
              radius: 40,
              borderWidth: 1,
              marginBottom: 30,
              paddingLeft: 20,
              paddingRight: 20,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (s) {
                ToastUtil.show(S.of(context).login);
              },
              focusNode: _focusNodePassword,
              controller: _controllerPassword,
              keyboardType: TextInputType.text,
            ),
            Button(
              S.of(context).login,
              borderRadius: 40,
              onPressed: () {
                ToastUtil.show(S.of(context).login);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Text(S.of(context).registerRightNow),
                  onTap: () => Navigator.of(context).pushNamed(
                      RouteName.register_first_step,
                      arguments: true),
                ),
                GestureDetector(
                  child: Text(S.of(context).forgetPassword),
                  onTap: () => Navigator.of(context).pushNamed(
                      RouteName.register_first_step,
                      arguments: false),
                ),
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

///三方登录
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
              color: theme.hintColor,
              height: 0.6,
              width: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                S.of(context).weChatLogin,
              ),
            ),
            Container(
              color: theme.hintColor,
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
                  ToastUtil.show(S.of(context).weChatLogin);
                },
                child: Image.asset(
                  ImageUtil.wrapAssets(
                      ImageUtil.IMAGE_TYPE_START, 'ic_we_chat_login.png'),
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
