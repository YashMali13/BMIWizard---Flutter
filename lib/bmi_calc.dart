import 'package:bmi/signin.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
    ),
    home: SignInScreen(), // Set SignInScreen as the initial route
  ));
}
class BMICalculationScreen extends StatelessWidget {
  const BMICalculationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('yourBMI'),
        actions: [
          IconButton(
            onPressed: () {
              // Clear all routes from the stack and navigate to the sign-in page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                    (route) => false,
              );
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  var msg = "";
  var bgColor = Colors.indigo.shade200;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BMI',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 21),
              TextField(
                controller: wtController,
                decoration: InputDecoration(
                  label: Text('Enter your weight in kgs'),
                  prefixIcon: Icon(Icons.line_weight),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: ftController,
                decoration: InputDecoration(
                  label: Text('Enter your height in feet'),
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 11),
              TextField(
                controller: inController,
                decoration: InputDecoration(
                  label: Text('Enter your height in Inch'),
                  prefixIcon: Icon(Icons.height),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  var wt = wtController.text.toString();
                  var ft = ftController.text.toString();
                  var inch = inController.text.toString();

                  if (wt != "" && ft != "" && inch != "") {
                    var iwt = int.parse(wt);
                    var iFt = int.parse(ft);
                    var iInch = int.parse(inch);

                    var tInch = (iFt * 12) + iInch;
                    var tCm = tInch * 2.54;
                    var tM = tCm / 100;

                    var bmi = iwt / (tM * tM);
                    String formattedBmi = bmi.toStringAsFixed(2);

                    if (bmi > 25) {
                      msg = "you are overweight";
                      bgColor = Colors.orange.shade200;
                    } else if (bmi < 18) {
                      msg = "you are underweight";
                      bgColor = Colors.red.shade200;
                    } else {
                      msg = "you are healthy";
                      bgColor = Colors.green.shade200;
                    }

                    setState(() {
                      result = "$msg \n Your BMI is: ${formattedBmi}";
                    });
                  } else {
                    setState(() {
                      result = "please fill all the required blanks";
                    });
                  }
                },
                child: Text('Calculate'),
              ),
              SizedBox(height: 11),
              Text(result, style: TextStyle(fontSize: 19)),
            ],
          ),
        ),
      ),
    );
  }
}
