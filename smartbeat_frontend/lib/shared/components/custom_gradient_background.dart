import 'package:flutter/material.dart';

class CustomGradientBackground extends StatelessWidget {
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  CustomGradientBackground({
    required this.colors,
    required this.begin,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.5,
      left: 0,
      right: 0,
      bottom: 0.0,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
