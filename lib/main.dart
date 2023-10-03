import 'package:bmi_31_3_2023/view/input_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF07091A),
        textTheme: TextTheme(bodyText2: TextStyle(color:Colors.white)),
        scaffoldBackgroundColor: Color(0xFF07091A),
   
  
      ),
      home:  InputPage(),
    );
  }
}

