import 'package:classmatesapp/constants/RegexValidator.dart';
import 'package:classmatesapp/screens/detailspage.dart';
import 'package:classmatesapp/screens/loginpage.dart';
import 'package:classmatesapp/widgets/authbutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../constants/constants.dart';
import 'package:flash/flash.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(border: Border.all()),
          child: ProgressHUD(
            child: Builder(builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 80.0,
                    ),
                    const Text(
                      'Hey nice to meet you, Hope you have fun here',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Ubuntu',
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'classmates@gmail.com'),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: emailChecker,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
                      validator: passwordValidator,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthenticationButton(
                            label: 'Register Now',
                            color: Colors.grey,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final progress = ProgressHUD.of(context);
                                progress!.show();
                                try {
                                  final newuser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  if (newuser != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                  email: email,
                                                ),),);
                                  }
                                } on Exception {
                                  progress.dismiss();
                                  showFlash(
                                    context: context,
                                    duration:
                                        const Duration(milliseconds: 2300),
                                    builder: (context, controller) {
                                      return Flash(
                                        controller: controller,
                                        behavior: FlashBehavior.floating,
                                        position: FlashPosition.bottom,
                                        boxShadows: kElevationToShadow[4],
                                        horizontalDismissDirection:
                                            HorizontalDismissDirection
                                                .horizontal,
                                        child: FlashBar(
                                          content: const Text(
                                              "Something went wrong please try again"),
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            height: MediaQuery.of(context).size.height / 10),
                        const SizedBox(
                          width: 10,
                        ),
                        AuthenticationButton(
                            label: 'Go to Login page',
                            color: Colors.grey,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            height: MediaQuery.of(context).size.height / 10)
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
