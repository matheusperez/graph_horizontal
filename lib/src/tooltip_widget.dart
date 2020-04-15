import 'package:flutter/material.dart';

class TooltipWidget extends StatelessWidget {
  final String title;
  final TextStyle style;
  final Color color;

  const TooltipWidget({Key key, this.title, this.style, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 30,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              title,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}

class ClipToolTip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 5.0);
    path.lineTo(size.width / 2 - 4, 5.0);
    path.lineTo(size.width / 2, 0.0);
    path.lineTo(size.width / 2 + 4, 5.0);
    path.lineTo(size.width, 5.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
