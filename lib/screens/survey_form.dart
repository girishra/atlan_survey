import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ongraph/screens/thank_you.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SurveyForm extends StatefulWidget {
  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  DateTime _selectedDate;
  String newDate;
  String newDateEnd;
  double rating = 0;
  bool yes = false;
  bool no = false;
  final List<String> sex = ['Male', 'Female', 'Rather not say'];
  String _selectedSex; // Option 2
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        var formatter = DateFormat('MM/dd/yyyy');
        String formatted = formatter.format(pickedDate);
        _selectedDate = pickedDate;
        newDate = formatted;
      });
    });
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  validator: (value) =>
                      value == null ? 'Please select Gender' : null,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  iconEnabledColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Gender',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  hint: Text(
                    '',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: _selectedSex,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSex = newValue;
                    });
                  },
                  items: sex.map((location) {
                    return DropdownMenuItem(
                      child: Text(
                        location,
                      ),
                      value: location,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ageCtrl,
                  decoration: InputDecoration(
                      hintText: 'Enter your age', border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  autovalidate: true,
                  child: TextFormField(
                    validator: (value) =>
                        isEmail(value) ? null : "Please enter a valid email",
                    controller: emailCtrl,
                    decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneCtrl,
                  decoration: InputDecoration(
                      hintText: 'Enter phone number (Optional)',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'How was your experience in our gaming center',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SmoothStarRating(
                    color: Colors.green,
                    borderColor: Colors.green,
                    size: 35,
                    starCount: 8,
                    rating: rating,
                    onRated: (value) {
                      setState(() {
                        rating = value;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: RaisedButton(
                    color: Colors.white,
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _selectedDate == null
                                ? 'Enter date of visit'
                                : newDate,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      _pickDateDialog();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Would you consider exploring our center again',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTheme(
                      minWidth: 150,
                      child: RaisedButton(
                        child: new Text('Yes'),
                        textColor: Colors.white,
                        color: yes ? Colors.green : Colors.grey,
                        onPressed: () {
                          setState(() {
                            yes = true;
                            no = false;
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 150,
                      child: RaisedButton(
                        child: new Text('No'),
                        textColor: Colors.white,
                        color: no ? Colors.red : Colors.grey,
                        onPressed: () {
                          setState(() {
                            yes = false;
                            no = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                nameCtrl.text == '' ||
                        emailCtrl.text == '' ||
                        ageCtrl.text == '' ||
                        rating == 0 ||
                        _selectedDate == null ||
                        _selectedSex == null ||
                        yes && no
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        width: double.infinity,
                        child: IgnorePointer(
                          child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        width: double.infinity,
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ThankYou()));
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
              ],
            ),
          ),
        ));
  }
}
