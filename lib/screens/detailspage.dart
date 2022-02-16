import 'package:classmatesapp/screens/landingscreen.dart';
import 'package:classmatesapp/screens/loginpage.dart';
import 'package:classmatesapp/widgets/authbutton.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../constants/RegexValidator.dart';
import '../constants/constants.dart';

class DetailsPage extends StatefulWidget {
  final String email;
  const DetailsPage({Key? key, required this.email}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  late String collegename;
  late String name;
  late String year;
  late String dept;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(border: Border.all()),
          child: ProgressHUD(
            child: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      const Text(
                        'Last few steps before you can see your profile',
                        style: TextStyle(
                            fontSize: 24, fontFamily: 'Ubuntu', color: Colors.black),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Your Name Here'),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        validator: emailChecker,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Your College Name Here'),
                        onChanged: (value) {
                          setState(() {
                            collegename = value;
                          });
                        },
                        validator: emailChecker,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Year Of Study Here'),
                        onChanged: (value) {
                          setState(() {
                            year = value;
                          });
                        },
                        validator: emailChecker,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter Your Department Name Here'),
                        onChanged: (value) {
                          setState(() {
                            dept = value;
                          });
                        },
                        validator: emailChecker,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      AuthenticationButton(
                        label: 'Submit',
                        color: Colors.grey,
                        onPressed: () {
                          final progress = ProgressHUD.of(context);
                          progress!.show();
                          _firestore.collection('user').add({
                            'email':widget.email,
                            'Name':name,
                            'CollegeName':collegename,
                            'Year':year,
                            'Department':dept,
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        height: MediaQuery.of(context).size.height / 10,
                      )
                    ],
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
