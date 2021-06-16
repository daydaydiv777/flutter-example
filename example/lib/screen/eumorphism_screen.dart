import 'package:flutter/material.dart';
import 'package:flutter_example/EumorphismWidget/neuomorphic_circle.dart';
import 'package:flutter_example/EumorphismWidget/eumorphism_cell.dart';

class Constants {
  static final backgroundColor = Color(0xFF2c3135);
  static final highlightColor = Colors.white.withOpacity(0.05);
  static final shadowColor = Colors.black87;

  static final softHighlightColor = Constants.highlightColor.withOpacity(0.03);
  static final softShadowColor = Constants.shadowColor.withOpacity(0.3);

  static final gradientStart = Color(0xFFf1da95);
  static final gradientMiddle = Color(0xFFfe948a);
  static final gradientEnd = Color(0xFFb24fce);
}

class EumorphismScreen extends StatefulWidget {
  const EumorphismScreen({Key key}) : super(key: key);

  @override
  _EumorphismScreenState createState() => _EumorphismScreenState();
}

class _EumorphismScreenState extends State<EumorphismScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: NeuomorphicCircle(
                backgroundColor: Constants.backgroundColor,
                highlightColor: Constants.highlightColor,
                shadowColor: Constants.shadowColor,
                innerShadow: true,
                outerShadow: false,
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "14th",
                        style: TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            EumorphismCell(
              backgroundColor: Constants.backgroundColor,
              softHighlightColor: Constants.softHighlightColor,
              softShadowColor: Constants.softShadowColor,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(
                  child: Text(
                    "EumorphismCell",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
