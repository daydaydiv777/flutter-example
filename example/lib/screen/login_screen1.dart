import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key key}) : super(key: key);

  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  Color normalColor = Color(0x80fafafa);
  Color focusColor = Color(0xFFffffff);
  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController usernameTextEditingController;
  TextEditingController passwordTextEditingController;

  @override
  void initState() {
    usernameFocusNode.addListener(() {
      setState(() {});
    });
    passwordFocusNode.addListener(() {
      setState(() {});
    });
    usernameTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        /// 界面全局点击事件，判断点击空白区域收起软键盘
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: Container(
          child: Stack(
            children: [
              buildBackground(),
              buildBlurMask(),
              buildBodyWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildBackground() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Image.asset(
        "assets/images/image1.jpg",
        fit: BoxFit.fill,
      ),
    );
  }

  Positioned buildBodyWidget() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            buildLogoWidget(),
            buildFormWidget()
          ],
        ),
      ),
    );
  }

  Row buildLogoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "同程旅行商户",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        )
      ],
    );
  }

  // 高斯模糊
  Widget buildBlurMask() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.6, sigmaY: 0.6),
      child: Container(
        color: Colors.black.withOpacity(0.1),
      ),
    );
  }

  Widget buildFormWidget() {
    return Container(
      child: Column(
        children: [
          buildUsernameFormItem(),
          SizedBox(
            height: 30.0,
          ),
          buildPasswordFormItem(),
          SizedBox(
            height: 130.0,
          ),
          buildSubmitWidget()
        ],
      ),
    );
  }

  Widget buildUsernameFormItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        color: Color(0x50fafafa),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(
            color: usernameFocusNode.hasFocus ? focusColor : normalColor),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.phone_android,
              color: Color(0xaafafafa),
              size: 26,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 1.0,
              height: 26,
              color: Color(0xaafafafa),
            ),
          ),
          Expanded(
            child: TextField(
              controller: usernameTextEditingController,
              focusNode: usernameFocusNode,

              /// 键盘回车事件
              onSubmitted: (val) {
                usernameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },

              /// 输入文本格式校验
              inputFormatters: [LengthLimitingTextInputFormatter(11)],

              /// 设置键盘类型
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "请输入手机号",
                hintStyle: TextStyle(
                  color: Color(0xaafafafa),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          usernameFocusNode.hasFocus
              ? InkWell(
                  onTap: () {
                    setState(() {
                      usernameTextEditingController.text = '';
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 12),
                    child: Icon(
                      Icons.cancel,
                      size: 22,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget buildPasswordFormItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        color: Color(0x50fafafa),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: normalColor),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.phone_android,
              color: Color(0xaafafafa),
              size: 26,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 1.0,
              height: 26,
              color: Color(0xaafafafa),
            ),
          ),
          Expanded(
            child: TextField(
              controller: passwordTextEditingController,
              focusNode: passwordFocusNode,

              /// 键盘回车事件
              onSubmitted: (val) {
                usernameFocusNode.unfocus();
              },

              /// 输入文本格式校验
              inputFormatters: [LengthLimitingTextInputFormatter(11)],

              /// 设置键盘类型
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "请输入密码",
                hintStyle: TextStyle(
                  color: Color(0xaafafafa),
                ),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSubmitWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 22.0),
      decoration: BoxDecoration(
        color: Color(0x50fafafa),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Center(
        child: InkWell(
          onTap: () {},
          child: Text(
            '登录',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
