import 'package:classmatesapp/screens/loginpage.dart';
import 'package:classmatesapp/screens/registrationpage.dart';
import 'package:classmatesapp/widgets/authbutton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Classmates App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Center(
            child: Text(
              'classmates',
              style: TextStyle(
                  fontFamily: 'Ubuntu', fontSize: 40, color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthenticationButton(
                label: "Login",
                color: Colors.grey,
                height: MediaQuery.of(context).size.height / 10,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
              SizedBox(width: 15,),
              AuthenticationButton(
                color: Colors.grey,
                label: 'Register',
                height: MediaQuery.of(context).size.height / 10,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
