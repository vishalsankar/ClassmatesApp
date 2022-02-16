import 'dart:convert';

import 'package:classmatesapp/modals/profile.dart';
import 'package:classmatesapp/screens/grouppage.dart';
import 'package:classmatesapp/screens/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../modals/students.dart';

List<dynamic> students = [];

class LandingPage extends StatefulWidget {
  static String id = 'Default_Page';

  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future<void> getStudent() async {
    String response = await rootBundle.loadString('assets/students.json');
    var decodeddata = await jsonDecode(response);
    setState(() {
      students = decodeddata["students"]
          .map((data) => Student.fromJson(data))
          .toList();
    });
    print(students);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudent();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Profile>(
      create: (context) => Profile(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ProfilePage.id,
        routes: {
          ProfilePage.id: (context) => ProfilePage(student: students,),
          GroupPage.id: (context) => GroupPage(student: students,),
        },
      )

    );
  }
}


