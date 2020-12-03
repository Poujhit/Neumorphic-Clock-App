import 'package:flutter/material.dart';

class ElevationWidget extends StatelessWidget {
  final CustomPainter paint;
  final Widget child;
  final double width;
  final double height;
  ElevationWidget({
    this.paint,
    this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 18,
        borderOnForeground: false,
        shadowColor: const Color(0xFFb9abab),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(300),
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF806a6a),
                offset: Offset(0, 10),
                blurRadius: 34,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0xFFb9abab),
                offset: Offset(0, -25),
                blurRadius: 34,
                spreadRadius: 0,
              ),
            ],
          ),
          child: CustomPaint(
            painter: paint,
            child: child,
          ),
        ),
      ),
    );
  }
}
