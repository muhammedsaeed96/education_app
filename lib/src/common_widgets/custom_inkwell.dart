import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  const CustomInkwell({
    super.key,
    required this.child,
    this.tap,
    this.radius = 16.0,
  });

  final Widget child;
  final VoidCallback? tap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      child,
      Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // splashColor: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(radius),
            onTap: tap,
          ),
        ),
      ),
    ]);
  }
}
