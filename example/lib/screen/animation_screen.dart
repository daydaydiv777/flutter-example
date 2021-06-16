import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key key}) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(seconds: 1),
        vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _animationController.forward();
                  },
                  child: Text('执行一次'),
                ),
                GestureDetector(
                  onTap: () {
                    _animationController.reset();
                  },
                  child: Text('重置'),
                ),
                GestureDetector(
                  onTap: () {
                    _animationController.stop();
                  },
                  child: Text('停止'),
                ),
                GestureDetector(
                  onTap: () {
                    _animationController.repeat(reverse: true);
                  },
                  child: Text('重复执行'),
                ),
              ],
            ),
            RotationTransition(
              turns: _animationController,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
            ScaleTransition(
              scale: _animationController,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
