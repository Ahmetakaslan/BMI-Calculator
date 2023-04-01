import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  Color color;
  Widget? child;
  MyContainer({required this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        //#1C1C2D
        //0xFF0C1234
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(15),
    );
  }
}