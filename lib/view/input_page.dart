import 'dart:io';

import 'package:bmi_31_3_2023/Default/d_ContainerChaild.dart';
import 'package:bmi_31_3_2023/Default/default_Container.dart';
import 'package:bmi_31_3_2023/view/calculateScreen.dart';
import 'package:bmi_31_3_2023/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Gender {
  male,
  female,
}

enum AddRemove { addWeight, removeWeight, addAge, removeAge }

class InputPage extends StatefulWidget {
   InputPage();
  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleColour = kactiveColor;
  Color femaleColour = kinactiveColor;
  Gender gender=Gender.male;
// in this you will change  back color of selected Gender
  void updateColor(Gender select) {
    if (select == Gender.male) {
      gender=Gender.male;
      maleColour = kactiveColor;
      femaleColour = kinactiveColor;
      setState(() {});
    } else {
      gender=Gender.female;
      femaleColour = kactiveColor;
      maleColour = kinactiveColor;
      setState(() {});
    }
  }

  void funaddOrRemoveHeight(AddRemove a) {
    if (a == AddRemove.addWeight) {
      weight < 290 ? weight++ : debugPrint("Aralık dışı");
    } else if (a == AddRemove.removeWeight) {
      weight > 0 ? weight-- : debugPrint("Aralık dışı");
    } else if (a == AddRemove.addAge) {
      age < 150 ? age++ : debugPrint("Aralık dışı");
    } else {
      age > 0 ? age-- : debugPrint("Aralık dışı");
    }
    setState(() {});
  }
  Future<bool> closeApp() async {
    return exit(0);
  }
  int height = 90;
  int weight = 50;
  int age = 30;
  int firstValue=50;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF07091A),
        title: Text("BMI Calculator"),
      ),
      body: WillPopScope(
        onWillPop: ()=>closeApp(),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("hsh");
                          updateColor(Gender.male);
                        },
                        child: MyContainer(
                          child: ContainerChild(
                            icons: FontAwesomeIcons.mars,
                            text: "Male",
                            size: 80,
                          ),
                          color: maleColour,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("hsh");
                          updateColor(Gender.female);
                        },
                        child: MyContainer(
                          child: ContainerChild(
                            icons: FontAwesomeIcons.venus,
                            text: "Female",
                            size: 80,
                          ),
                          color: femaleColour,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: MyContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Height",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "$height  cm",
                        style: kdefultTextStyle,
                      ),
                      SliderTheme(
                        data: SliderThemeData(thumbColor: Colors.yellow),
                        child: Slider(
                          
                          divisions: 290,
                          label:"$firstValue",
                          
                          min: 0,
                          max: 290,
                          activeColor: Color.fromARGB(255, 240, 47, 33),
                          inactiveColor: Color.fromARGB(255, 179, 177, 177),
                          value: height.toDouble(),
                          onChanged: (value) {
                            print(height);
                            setState(
                              () {
                                firstValue=value.round();
                                height = value.round();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  color: kactiveColor,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: MyContainer(
                        color: kactiveColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "WEIGHT",
                              style: kdefultTextStyle,
                            ),
                            Text("$weight",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BottomButton(
                                  icon: Icons.remove,
                                  fun: () {
                                    funaddOrRemoveHeight(AddRemove.removeWeight);
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                BottomButton(
                                  icon: Icons.add,
                                  fun: () {
                                    funaddOrRemoveHeight(AddRemove.addWeight);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: MyContainer(
                        color: kactiveColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "AGE",
                              style: kdefultTextStyle,
                            ),
                            Text(
                              "$age",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BottomButton(
                                  icon: Icons.remove,
                                  fun: () {
                                    funaddOrRemoveHeight(AddRemove.removeAge);
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                BottomButton(
                                  icon: Icons.add,
                                  fun: () {
                                    funaddOrRemoveHeight(AddRemove.addAge);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalculateScreen(height: height,weight: weight,age: age,gender: gender,),
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      height: bottomNavigatorHeight,
                      decoration: BoxDecoration(
                        color: Color(0xFFEA1556),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalculateScreen(
                            height: height,
                            weight: weight,
                            age: age,
                            gender:gender ,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Calculate",
                      style: kdefultTextStyle,
                    ),
                  ),
                  Positioned(
                    top: 57,
                    left: 160,
                    child: Container(
                      color: Colors.black,
                      height: 5,
                      width: 92,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final IconData icon;
  final Function? fun;
  const BottomButton({required this.icon, this.fun});
// bu button daha fazla özelliğe sahip
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        fun!();
      },
      child: Icon(
        icon,
        color: Colors.white,
      ),
      elevation: 4.0,
      constraints: BoxConstraints.tightFor(height: 60, width: 60),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}
