import 'package:flutter/material.dart';

class NeuomorphicCircle extends StatelessWidget {
  final Color highlightColor;
  final Color shadowColor;
  final Color backgroundColor;
  final bool innerShadow;
  final bool outerShadow;
  final Widget child;

  const NeuomorphicCircle(
      {Key key,
      this.highlightColor,
      this.shadowColor,
      this.backgroundColor,
      this.child,
      this.innerShadow,
      this.outerShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            boxShadow: (outerShadow)
                ? [
                    BoxShadow(
                        color: highlightColor,
                        offset: Offset(-10, -10),
                        spreadRadius: 0,
                        blurRadius: 20),
                    BoxShadow(
                        color: shadowColor,
                        offset: Offset(10, 10),
                        spreadRadius: 0,
                        blurRadius: 20)
                  ]
                : null,
          ),
        ),
        (innerShadow)
            ? ClipPath(
                clipper: HighlightClipper(),
                child: CircleInnerHighlight(
                  highlightColor: highlightColor,
                  backgroundColor: backgroundColor,
                ),
              )
            : SizedBox.shrink(),
        (innerShadow)
            ? ClipPath(
                clipper: ShadowClipper(),
                child: CircleInnerShadow(
                  shadowColor: shadowColor,
                  backgroundColor: backgroundColor,
                ),
              )
            : SizedBox.shrink(),
        (child != null) ? child : SizedBox.shrink()
      ],
    );
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HighlightClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
}

class CircleInnerHighlight extends StatelessWidget {
  final Color highlightColor;
  final Color backgroundColor;
  const CircleInnerHighlight(
      {Key key, this.highlightColor, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            highlightColor,
          ],
          center: AlignmentDirectional(-0.05, -0.05),
          focal: AlignmentDirectional(-0.05, -0.05),
          radius: 0.6,
          focalRadius: 0.1,
          stops: [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.55, 1],
              colors: [backgroundColor, backgroundColor.withOpacity(0)]),
        ),
      ),
    );
  }
}

class CircleInnerShadow extends StatelessWidget {
  final Color shadowColor;
  final Color backgroundColor;

  const CircleInnerShadow(
      {Key key, @required this.shadowColor, @required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            backgroundColor,
            shadowColor,
          ],
          center: AlignmentDirectional(0.05, 0.05),
          focal: AlignmentDirectional(0, 0),
          radius: 0.5,
          focalRadius: 0,
          stops: [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 0.45],
                colors: [backgroundColor.withOpacity(0), backgroundColor])),
      ),
    );
  }
}
