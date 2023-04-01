import 'package:bmi_31_3_2023/DataBaseHelper.dart';
import 'package:bmi_31_3_2023/detail.dart';
import 'package:bmi_31_3_2023/const.dart';
import 'package:bmi_31_3_2023/input_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CalculateScreen extends StatefulWidget {
  int height;
  int weight;
  int age;
  Gender gender;

  CalculateScreen(
      {super.key,
      required this.height,
      required this.weight,
      required,
      required this.age,
      required this.gender});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final Uri _url =
      Uri.parse('https://github.com/Ahmetakaslan/Gelisim_Takip_Uygulamasi_ui');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color color = Colors.green;
  String? answer;
  double? answerDouble;
  late DateTime dateTime;
  String textCase = "Normal";
  String? text1 = "You have a normal body";
  String? text2 = "weight. Good job!";
  String textDb = "Normal";
  funCalculateBmi() {
    answerDouble = ((widget.weight / (widget.height * widget.height)) * 10000);
    answer = answerDouble?.toStringAsFixed(2);
    funControl(answerDouble!);
  }

  funControl(double answerDouble) {
    if (18.5 == answerDouble) {
      text1 = "you are on the border";
      text2 = "🤨";
      color = Colors.yellow;
      textCase = "Be Carefull";
      textDb = "Border";
    } else if (25 == answerDouble) {
      text1 = "you are on the border";
      text2 = "🤨";
      color = Colors.yellow;
      textCase = "Be Carefull";
      textDb = "Border";
    } else if (18.5 < answerDouble && answerDouble < 25) {
      text1 = "You have a normal body";
      text2 = "weight. Good job! 😀";
      color = Colors.green;
      textCase = "Normal";
      textDb = "Normal";
    } else {
      text1 = "sorry but you have an unhealthy body";
      text2 = "Weight.You must be careful 😨";
      color = Colors.red;
      textCase = "you should exercise";
      textDb = "Bad";
    }
    setState(() {});
  }

  @override
  void initState() {
    dateTime = DateTime.now();
    funCalculateBmi();
  }

  Future<void> Save() async {


    try {
      var db = await DataBaseHelper.connectToDatabase();
      var mapim = Map<String, dynamic>();
      mapim["height"] = widget.height.toString();
      mapim["weight"] = widget.weight.toString();
      mapim["date"] = dateTime.toString();
      mapim["value"] = answer.toString();
      mapim["age"] = widget.age.toString();
      mapim["gender"] =widget.gender.toString();
      mapim["status"]=textDb;
      db.insert("BMI", mapim);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 1),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            height: bottomNavigatorHeight,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Added",
              style: defaultStyle(size: 25, color: Colors.white),
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint("Dont add : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Color.fromARGB(255, 55, 57, 87),
          ),
          width: size.width * .5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detail(),
                    ),
                  );
                },
                child: Text("Go Data"),
              ),
              SizedBox(
                width: size.width * .5 / 1.5,
                child: Divider(
                  color: Colors.white,
                  thickness: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (!await launchUrl(_url)) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  child: Text(
                    "Source Code",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kdefaultColor,
        title: Text(
          "BMI CALCULATOR",
          style: kdefultTextStyle,
        ),
        leading: IconButton(
          icon: Image.asset(
            "assets/menu-bar.png",
            color: Colors.white,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      backgroundColor: kdefaultColor,
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              "Your Result",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ),
          Expanded(
            child: Container(
              width: size.width * .8,
              decoration: BoxDecoration(color: kactiveColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$textCase",
                    style: defaultStyle(
                        size: 30, fontWeight: FontWeight.bold, color: color),
                  ),
                  Text(
                    "$answer",
                    style: defaultStyle(
                        size: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Column(
                    children: [
                      Text(
                        "Normal BMI range:",
                        textAlign: TextAlign.center,
                        style: defaultStyle(
                            size: 20,
                            color: Color.fromARGB(255, 177, 179, 179),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "18,5 - 25kg/m2",
                        textAlign: TextAlign.center,
                        style: defaultStyle(
                            size: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$text1",
                        textAlign: TextAlign.center,
                        style: defaultStyle(
                            size: 20,
                            color: Color.fromARGB(255, 177, 179, 179),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$text2",
                        textAlign: TextAlign.center,
                        style: defaultStyle(
                            size: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  BottomButton(
                    icon: Icons.save,
                    fun: () {
                      Save();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(),
                )),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: bottomNavigatorHeight,
              decoration: BoxDecoration(
                color: Color(0xFFEA1556),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Text(
                "RE-CALCULATE YOUR BMI",
                style: defaultStyle(size: 20),
              ),
            ),
          ),
        ],
      )),
    );
  }

  TextStyle defaultStyle(
      {required double size,
      FontWeight fontWeight = FontWeight.bold,
      Color color = Colors.white}) {
    return TextStyle(fontSize: size, color: color, fontWeight: fontWeight);
  }
}
