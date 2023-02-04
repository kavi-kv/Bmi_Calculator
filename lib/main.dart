import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BmiCalculator(),
  ));
}

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentIndex = 0;
  String? result;
  String levelOutcome = "";

  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bmi Calculator",
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Man", Colors.blue, 0),
                  radioButton("Woman", Colors.pink, 1),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                "Your Height in Cm",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none),
                  hintText: "Enter your height in cm",
                  hintStyle: TextStyle(fontSize: 19.0),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Your Height in Kg",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none),
                  hintText: "Enter your weight in kg",
                  hintStyle: TextStyle(fontSize: 19.0),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                width: double.infinity,
                height: 60.0,
                color: Colors.blue,
                child: OutlinedButton(
                  onPressed: () {
                    double height = double.parse(_heightController.value.text);
                    double weight = double.parse(_weightController.value.text);
                    calBmi(height, weight);
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontSize: 24.0, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Your BMI is : ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "$result",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "$levelOutcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        height: 80,
        decoration: BoxDecoration(
          color: currentIndex == index ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextButton(
          onPressed: () {
            changeIndex(index);
          },
          child: Text(
            value,
            style: TextStyle(
                fontSize: 18.0,
                color: currentIndex == index ? Colors.white : color),
          ),
        ),
      ),
    );
  }

  void bmiLevel(double res) {
    String level = "";
    if (res <= 15) {
      level = "Severly underweight";
    } else if (res > 15 && res < 18.5) {
      level = "Underweight";
    } else if (res > 18.5 && res < 25) {
      level = "Normal";
    } else if (res >= 25 && res <= 30) {
      level = "Overweight";
    } else if (res > 31 && res <= 35) {
      level = "Obese I";
    }
    else if (res > 36 && res < 45) {
      level = "Obese II";
    }
    else {
      level = "Obese III";
    }
    setState(() {
      levelOutcome = level;
    });
  }

  void calBmi(double height, double weight) {
    double outcome = weight / (height * height / 10000);
    String bmi = outcome.toStringAsFixed(2);
    bmiLevel(outcome);
    setState(() {
      result = bmi;
    });
  }
}
