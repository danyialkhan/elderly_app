import 'package:elderly_app/screens/home/home_screen.dart';
import 'package:elderly_app/widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitialSetupScreen extends StatefulWidget {
  static const String id = 'Initial_Screen';
  @override
  _InitialSetupScreenState createState() => _InitialSetupScreenState();
}

class _InitialSetupScreenState extends State<InitialSetupScreen> {
  bool isCompleted = false;
  final userNameController = new TextEditingController();
  final relative1Controller = new TextEditingController();
  final relative2Controller = new TextEditingController();
  final relative1NumController = new TextEditingController();
  final relative2NumController = new TextEditingController();
  final fireStoreDatabase = Firestore.instance;
  String userName, relative1name, relative2name, relative1num, relative2num;
  int age, gender;
  String genderValue;
  @override
  void dispose() {
    userNameController.dispose();
    relative1Controller.dispose();
    relative2Controller.dispose();
    relative2NumController.dispose();
    relative1NumController.dispose();
    super.dispose();
  }

  FirebaseUser loggedInUser;
  String email, userId;
  void getCurrentUser() async {
    try {
      final user = await auth.currentUser();
      loggedInUser = user;
      email = loggedInUser.email;
      userId = loggedInUser.uid;
    } catch (e) {
      print(e);
    }
  }

  final auth = FirebaseAuth.instance;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Elderly '),
            Text(
              'Care',
              style: TextStyle(color: Colors.green),
            ),
            Padding(
              padding: EdgeInsets.only(right: 35),
            )
          ],
        ),
        elevation: 1,
      ),
      body: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return RichAlertDialog(
                  alertTitle: richTitle("Complete the Setup."),
                  alertSubtitle:
                      richSubtitle('Please provide details to continue'),
                  alertType: RichAlertType.WARNING,
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
          return await Future.value(false);
        },
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  'Complete the Initial setup',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'The app requires you to give some data during this setup. Kindly enter all required data to all the fields below for best performance.',
                style: TextStyle(
                    fontWeight: FontWeight.w200, color: Colors.indigo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Name : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      hintText: 'Enter  User Name',
                      controller: userNameController,
                      onChanged: (value) {
                        print('Name Saved');
                        setState(() {
                          userName = value;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 0),
              child: Text(
                'Gender : ',
                style: TextStyle(fontSize: 17),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Male : '),
                  Radio(
                    onChanged: (value) {
                      setState(() {
                        genderValue = 'Male';
                      });
                    },
                    activeColor: Color(0xffE3952D),
                    value: 1,
                    groupValue: gender,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Female : '),
                  Radio(
                    onChanged: (value) {
                      setState(() {
                        genderValue = 'Female';
                      });
                    },
                    activeColor: Color(0xffE3952D),
                    value: 2,
                    groupValue: gender,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(' Relative Name : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Name of the user',
                      hintText: 'Enter Relative Name',
                      controller: relative1Controller,
                      onChanged: (value) {
                        setState(() {
                          relative1name = value;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Relative 1 : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      hintText: 'Enter mobile Number ',
                      controller: relative1NumController,
                      onChanged: (value) {
                        setState(() {
                          relative1num = value;
                        });
                      },
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 14, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text(' Relative Name : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      helperText: 'Name of the user',
                      hintText: 'Enter Relative Name',
                      controller: relative2Controller,
                      onChanged: (value) {
                        setState(() {
                          relative2name = value;
                        });
                      },
                      isNumber: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(child: Text('Relative 2 : ')),
                  Expanded(
                    flex: 6,
                    child: FormItem(
                      hintText: 'Enter mobile Number ',
                      controller: relative2NumController,
                      onChanged: (value) {
                        setState(() {
                          relative2num = value;
                        });
                      },
                      isNumber: true,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await createRecord();
                setState(() {
                  initialSetupComplete = true;
                });

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(50, 20, 50, 30),
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 65.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.greenAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 3.0,
                      offset: Offset(0, 4.0),
                    ),
                  ],
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createRecord() async {
    await fireStoreDatabase.collection("profile").document(userId).setData({
      'userName': userName,
      'email': email,
      'userId': userId,
      'height': 0,
      'weight': 0,
      'age': 0,
      'gender': genderValue,
      'bloodGroup': 'Not Set',
      'allergies': 'Not Set',
      'relative1number': relative1num,
      'relative1name': relative1name,
      'relative2number': relative2num,
      'relative2name': relative2name,
      'bloodSugar': 'Not set',
      'bloodPressure': 'Not set',
    });

//    DocumentReference ref = await fireStoreDatabase.collection("books").add({
//      'title': 'Flutter in Action',
//      'description': 'Complete Programming Guide to learn Flutter'
//    });
  }
}

bool initialSetupComplete = false;

class TextInputField extends StatelessWidget {
  var editingController = TextEditingController();
  final String helperText;
  final String hintText;
  Function valueGetter;
  IconData icon;

  TextInputField(
      {this.editingController,
      this.valueGetter,
      this.helperText,
      this.hintText,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: editingController,
        style: TextStyle(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
          helperText: helperText,
          icon: Icon(icon, color: Colors.blueAccent),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Colors.indigo, style: BorderStyle.solid)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: Color(0xffaf5676), style: BorderStyle.solid)),
        ),
        onChanged: valueGetter,
      ),
    );
  }
}
