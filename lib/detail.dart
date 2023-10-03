import 'package:bmi_31_3_2023/DataBaseHelper.dart';
import 'package:bmi_31_3_2023/const.dart';
import 'package:bmi_31_3_2023/healthOutcomes.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<List<BMI>> getAllData() async {
    var db = await DataBaseHelper.connectToDatabase();
    var list = await db.rawQuery("Select * from BMI");
    return List.generate(
      list.length,
      (index) {
        var first = list[index];
        var id = int.parse(first["id"].toString());
        var age = first["age"] as String;
        var date = first["date"] as String;
        var weight = first["weight"] as String;
        var height = first["height"] as String;
        var gender = first["gender"] as String;
        var value = first["value"] as String;
        var status = first["status"] as String;
        return BMI(
            id: id,
            date: date,
            gender: gender,
            height: height,
            weight: weight,
            age: age,
            status: status,
            value: value);
      },
    ).reversed.toList();
  }

  Future<void> Delete(int id) async {
    var db = await DataBaseHelper.connectToDatabase();
    db.delete("BMI", where: "id = ?", whereArgs: [id]);
  }

  Future<void> DeleteAll() async {
    var db = await DataBaseHelper.connectToDatabase();
    db.delete("BMI");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                DeleteAll();
              },
              icon: Icon(Icons.delete))
        ],
        backgroundColor: kdefaultColor,
        title: Text("Your Data"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var listem = snapshot.data;
            return ListView.builder(
              itemCount: listem!.length,
              itemBuilder: (context, index) {
                var firstValue = listem![index];

                return Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        defaultTexts(firstValue.date, "Date",Colors.black),
                        defaultTexts(firstValue.status, "Status",Colors.red),
                        defaultTexts(firstValue.value, "Value",Colors.black),
                        defaultTexts(firstValue.gender, "Gender",Colors.black),
                        defaultTexts(firstValue.age, "Age",Colors.black),
                        defaultTexts(firstValue.height, "Height",Colors.black),
                        defaultTexts(firstValue.weight, "Weight",Colors.black),
                        IconButton(
                          onPressed: () {
                            Delete(firstValue.id);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        },
      ),
    );
  }

  Padding defaultTexts(
    String firstValue,
    String text,
    Color color,
    
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "$text",
            style: defaultTextStyle(Colors.green  ),
          ),
          Text(
            "${firstValue}",
            style: defaultTextStyle(color),
          ),
        ],
      ),
    );
  }

  TextStyle defaultTextStyle(Color color) => TextStyle(color: color, fontSize: 16);
}
