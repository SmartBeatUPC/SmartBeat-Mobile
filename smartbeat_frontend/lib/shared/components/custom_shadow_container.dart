import 'package:flutter/material.dart';

class CustomShadowContainer extends StatelessWidget {
  final BorderRadiusGeometry borderRadius;
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Border? border;
  final double borderOpacity;

  const CustomShadowContainer({
    super.key,
    required this.child,
    required this.borderRadius,
    this.color,
    this.padding,
    this.width,
    this.border,
    this.borderOpacity = 0.1,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
          color: color,
          border: border,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(borderOpacity),
              blurRadius: 10.0,
              spreadRadius: 4.0,
            ),
          ]),
      child: Column(
        children: [
          child,
        ],
      ),
    );
  }
}
