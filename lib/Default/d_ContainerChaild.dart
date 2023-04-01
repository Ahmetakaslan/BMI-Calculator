import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerChild extends StatelessWidget {
  IconData icons;
  String text;
  Color? color;
  double? size;
  ContainerChild({required this.icons,required this.text,this.color=Colors.white,this.size=55});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icons, color: color, size: size),
        SizedBox(
          height: 15,
        ),
        Text(
        text  ,
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}


