import 'package:flutter/material.dart';
import 'package:flutter_example/BubbleBackground/bubble_background.dart';

class BubbleLoginScreen extends StatefulWidget {
  const BubbleLoginScreen({Key key}) : super(key: key);

  @override
  _BubbleLoginScreenState createState() => _BubbleLoginScreenState();
}

class _BubbleLoginScreenState extends State<BubbleLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('登录'),
      // ),
      body: BubbleBackground(),
    );
  }
}
