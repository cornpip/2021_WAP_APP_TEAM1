import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TGTButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Widget child;
  final VoidCallback onPressed;

  const TGTButton(
      {Key? key,
        required this.child,
        required this.onPressed,
        this.width = 50.0,
        this.height = 50.0,
        this.borderRadius = 80.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoxDecoration _decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff3C43F8), Color(0x787A12FF)],
      ),
    );

    return Container(
      child: MaterialButton(
        padding: EdgeInsets.zero,
        hoverElevation: 100.0,
        hoverColor: Colors.black,
        child: child,
        onPressed: onPressed,
      ),
      width: width,
      height: height,
      decoration: _decoration,
    );
  }
}