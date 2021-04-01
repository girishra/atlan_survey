import 'package:flutter/material.dart';
import 'package:ongraph/screens/survey_form.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Atlan Survey',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Center(
                  child: Text(
                    "Welcome to  personal information survey. Let's Begin!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'We are collecting information of users\nvisiting our center',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              width: 180,
              child: FlatButton(
                child: Text('Start'),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => SurveyForm()));
                },
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
