import 'package:classmatesapp/screens/landingscreen.dart';
import 'package:classmatesapp/screens/registrationpage.dart';
import 'package:classmatesapp/widgets/authbutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/RegexValidator.dart';
import '../constants/constants.dart';
import 'package:flash/flash.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginPage extends StatefulWidget {
  static String id = 'Login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;

  FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

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
                      'It\'s been a while, nice to see you again',
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
                          label: 'Login',
                          color: Colors.grey,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final progress = ProgressHUD.of(context);
                              progress!.show();
                              try {
                                var user =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LandingPage(),
                                      ),
                                      (Route<dynamic> route) => false);
                                }
                              } on Exception {
                                progress.dismiss();
                                showFlash(
                                  context: context,
                                  duration: const Duration(milliseconds: 2000),
                                  builder: (context, controller) {
                                    return Flash(
                                      controller: controller,
                                      behavior: FlashBehavior.floating,
                                      position: FlashPosition.bottom,
                                      boxShadows: kElevationToShadow[4],
                                      horizontalDismissDirection:
                                          HorizontalDismissDirection.horizontal,
                                      child: FlashBar(
                                        content:
                                            const Text("Wrong Email/Password"),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        AuthenticationButton(
                            label: 'Go to Registration page',
                            color: Colors.grey,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationPage()));
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
