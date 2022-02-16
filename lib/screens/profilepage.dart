import 'package:classmatesapp/screens/showbadges.dart';
import 'package:classmatesapp/widgets/badgesbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:classmatesapp/screens/addbadgespage.dart';
import 'package:classmatesapp/screens/grouppage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modals/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  static String id = "Profile_Page";
  final List<dynamic> student;
  const ProfilePage({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firestore = FirebaseFirestore.instance;
  User? loggedInUser = _auth.currentUser;

  List<CircleAvatar> getBadges() {
    return Provider.of<Profile>(context).badges;
  }

  Future<void> getUserData() async {
    final userdata = await _firestore.collection('user').get();
    final userdocs = userdata.docs;
    for (var i in userdocs) {
      if (loggedInUser?.email == i['email']) {
        setState(() {
          Provider.of<Profile>(context, listen: false).changeName(i['Name']);
          Provider.of<Profile>(context, listen: false)
              .changeCollegeName(i['CollegeName']);
          Provider.of<Profile>(context, listen: false)
              .changeYear(i['Year']);
          Provider.of<Profile>(context, listen: false)
              .changeDept(i['Department']);
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: CollegeSearch(widget.student));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(18),
        child: ListView(
          children: [
            Row(
              children: [
                Image.network(
                  'https://media.istockphoto.com/vectors/male-user-icon-vector-id517998264?k=20&m=517998264&s=612x612&w=0&h=pdEwtkJlZsIoYBVeO2Bo4jJN6lxOuifgjaH8uMIaHTU=',
                  height: 150,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    const Text(
                      'Badges',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: Provider.of<Profile>(context).badges.isEmpty
                          ? [
                              const SizedBox(
                                width: 25,
                              ),
                              const Text(
                                'Pls Add badges',
                                style: TextStyle(color: Colors.grey),
                              )
                            ]
                          : getBadges(),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: const Text(
                'Name',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              subtitle: Text(
                Provider.of<Profile>(context).getName,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            ListTile(
              title: const Text(
                'College',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              subtitle: Text(
                Provider.of<Profile>(context).getCollegeName,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ListTile(
                    title: const Text(
                      'Year',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      Provider.of<Profile>(context).getYear,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListTile(
                    title: const Text(
                      'Department',
                      style: TextStyle(fontSize: 22),
                    ),
                    subtitle: Text(
                      Provider.of<Profile>(context).getDept,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BadgesButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowBadgesPage(
                    badges: Provider.of<Profile>(context).badges,
                  ),
                ),
              ),
              label: 'Show Badges',
            ),
            BadgesButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddBadgesPage()));
              },
              label: 'Add Badges',
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupPage(
                        collegeName:
                            Provider.of<Profile>(context,listen: false).getCollegeName,
                        year: Provider.of<Profile>(context).getYear,
                        dept: Provider.of<Profile>(context).getDept,
                        student: widget.student,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              backgroundColor: Colors.black,
              radius: 25,
            )
          ],
        ),
      ),
    );
  }
}

class CollegeSearch extends SearchDelegate<String> {
  final List<dynamic> student;
  CollegeSearch(this.student);
  final collegeName = [
    'VIT Chennai',
    'VIT Bhopal',
    'VIT Amravati',
    'VIT Vellore',
    'IIT Delhi',
    'IIT Kanpur',
    'IIT Madras',
    'NIT Trichy',
    'NIT Surat',
    'Delhi University',
    'Chandigarh University',
    'PSG Coimbatore'
  ]; //TODO: get all college names from database
  final recentCollege = [
    'VIT Chennai',
    'IIT Delhi',
    'NIT Trichy',
    'Chandigarh University',
  ]; //TODO: get recent College names from database

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    String year = '';
    String dept = '';
    for (var i in student) {
      if (i.collegeName == query) {
        year = i.year;
        dept = i.dept;
        break;
      }
    }
    return GroupPage(
      student: student,
      collegeName: query,
      year: year,
      dept: dept,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCollege
        : collegeName
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => GroupPage(
          //       student: student,
          //       collegeName: query,
          //
          //     ),
          //   ),
          // );
          showResults(context);
        },
        leading: const Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: const TextStyle(color: Colors.grey))
              ]),
        ),
      ),
    );
  }
}
