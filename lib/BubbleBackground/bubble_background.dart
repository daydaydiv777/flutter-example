import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BubbleBackground extends StatefulWidget {
  const BubbleBackground({Key key}) : super(key: key);

  @override
  _BubbleBackgroundState createState() => _BubbleBackgroundState();
}

// 生成随机颜色
Color getRandomWhiteColor(Random random) {
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class _BubbleBackgroundState extends State<BubbleBackground>
    with SingleTickerProviderStateMixin {
  // 气泡列表
  List<BubbleBean> _bubbleList = [];

  // 随机数
  Random _random = Random(DateTime
      .now()
      .microsecondsSinceEpoch);

  AnimationController _animationController;

  // 最大运动速度
  double _maxSpeed = 1.0;

  // 最大半径
  double _maxRadius = 100;

  // 最大角度
  double _maxAngle = 2 * pi;

  @override
  void initState() {
    for (int i = 0; i < 30; i++) {
      BubbleBean bean = BubbleBean();

      // 随机颜色
      bean.color = getRandomWhiteColor(_random);
      // 随机位置
      bean.position =
          Offset(_random.nextDouble() * 375, _random.nextDouble() * 667);
      // 随机速度
      bean.speed = _random.nextDouble() * _maxSpeed;
      // 半径
      bean.radius = _random.nextDouble() * _maxRadius;
      // 角度
      bean.angle = _random.nextDouble() * _maxAngle;

      bean.dx = _random.nextBool();
      bean.dy = _random.nextBool();

      _bubbleList.add(bean);
    }

    _animationController = AnimationController(
        duration: Duration(seconds: 1),
        // 垂直同步(Vertical Sync)，通过 SingleTickerProviderStateMixin 拿到设备刷新循序
        vsync: this
    )
      ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // 创建背景
          buildBackground(),
          // 绘制气泡
          buildBubbleWidget(context),
          // 高斯模糊
          // buildBlurWidget()
        ],
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: BoxDecoration(
        // 界面背景色线性渐变
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.lightBlueAccent.withOpacity(0.3),
                Colors.lightBlue.withOpacity(0.3),
                Colors.blue.withOpacity(0.3),
              ])),
    );
  }

  Widget buildBubbleWidget(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (_, __) {
        return CustomPaint(
            size: MediaQuery
                .of(context)
                .size,
            // 画布
            painter: CustomMyPainter(list: _bubbleList, random: _random));
      },
    );
  }

  Widget buildBlurWidget() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
      child: Container(
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}

// 创建画布
class CustomMyPainter extends CustomPainter {
  List<BubbleBean> list;
  Random random;

  CustomMyPainter({this.list, this.random});

  // 创建画笔
  Paint _paint = Paint()
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    list.forEach((element) {
      double dx = element.position.dx + element.calculateXY.dx;
      double dy = element.position.dy + element.calculateXY.dy;

      if (element.position.dx < - element.radius) {
        dx = size.width + element.radius;
      }
      if (element.position.dx > size.width + element.radius) {
        dx = -element.radius;
      }

      if (element.position.dy < -element.radius) {
        dy = size.height + element.radius;
      }
      if (element.position.dy > size.height + element.radius) {
        dy = -element.radius;
      }

      element.position = Offset(dx, dy);
    });

    list.forEach((element) {
      _paint.color = element.color;

      canvas.drawCircle(element.position, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // 返回false,不更新
    return true;
  }
}

// 气泡属性
class BubbleBean {
  // 位置
  Offset position;

  // 颜色
  Color color;

  // 运动速度
  double speed;

  // 运动角度
  double angle;

  // 半径
  double radius;

  Offset get calculateXY => Offset(speed * cos(angle), speed * sin(angle));

  // dx
  bool dx;
  bool dy;
}
