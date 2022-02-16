import 'package:classmatesapp/modals/students.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/profile.dart';

class GroupPage extends StatefulWidget {
  static String id = "Group_Page";

  final String collegeName;
  final String year;
  final String dept;
  final List<dynamic> student;
  const GroupPage(
      {Key? key,
      this.collegeName = '',
      this.year = '',
      this.dept = '',
      required this.student})
      : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<CircleAvatar> getBadges(Student student) {
    List<CircleAvatar> badges = [];
    for (var i in student.skills) {
      badges.add(CircleAvatar(
        child: Text(
          i.substring(0, 2),
        ),
        backgroundColor: Colors.green,
      ));
    }
    badges.add(CircleAvatar(
      child: Text(
        student.awards.substring(0, 2),
      ),
      backgroundColor: Colors.yellow,
    ));
    badges.add(CircleAvatar(
      child: Text(
        student.jobs.substring(0, 2),
      ),
      backgroundColor: Colors.purple,
    ));
    return badges;
  }

  List<ListTile> getClassmates(List<dynamic> students) {
    List<ListTile> classmates = [];
    for (var i in students) {
      if (i.collegeName == widget.collegeName) {
        classmates.add(
          ListTile(
            leading: CircleAvatar(
              child: const Icon(
                Icons.face,
              ),
              backgroundColor: Colors.grey[400],
            ),
            title: Text(i.name),
            subtitle: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: getBadges(i),
              ),
            ),
          ),
        );
      }
    }
    return classmates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  'College',
                  style: TextStyle(fontSize: 22),
                ),
                subtitle: Text(
                  widget.collegeName,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
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
                        widget.year,
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
                        widget.dept,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Classmates :',
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: ListView(
                    children: getClassmates(widget.student),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Invite Link',
                  style: TextStyle(fontSize: 22),
                ),
                subtitle: Row(
                  children: [
                    const Text(
                      'Join the Class', //TODO: must me changed to a proper invite link
                      style: TextStyle(fontSize: 20),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (Provider.of<Profile>(context).badges.isNotEmpty) {
                          if (widget.collegeName ==
                              Provider.of<Profile>(context, listen: false)
                                  .getCollegeName) {
                            final skill = [];
                            String award = '';
                            String jobs = '';
                            for (int i = 0;
                                i <
                                    Provider.of<Profile>(context, listen: false)
                                        .badges
                                        .length;
                                i++) {
                              if (Provider.of<Profile>(context, listen: false)
                                      .badges[i]
                                      .backgroundColor ==
                                  Colors.green) {
                                skill.add(
                                    Provider.of<Profile>(context, listen: false)
                                        .badgesDesc[i]);
                              } else if (Provider.of<Profile>(context,
                                          listen: false)
                                      .badges[i]
                                      .backgroundColor ==
                                  Colors.yellow) {
                                award =
                                    Provider.of<Profile>(context, listen: false)
                                        .badgesDesc[i];
                              } else {
                                jobs =
                                    Provider.of<Profile>(context, listen: false)
                                        .badgesDesc[i];
                              }
                            }
                            final nstd = Student(
                                Provider.of<Profile>(context, listen: false)
                                    .getName,
                                Provider.of<Profile>(context, listen: false)
                                    .getCollegeName,
                                Provider.of<Profile>(context, listen: false)
                                    .getYear,
                                Provider.of<Profile>(context, listen: false)
                                    .getDept,
                                skill,
                                award,
                                jobs);
                            setState(() {
                              if (widget.student[(widget.student.length - 1)]
                                      .name ==
                                  nstd.name) {
                                widget.student
                                    .removeAt(widget.student.length - 1);
                                widget.student.add(nstd);
                              } else {
                                widget.student.add(nstd);
                              }
                            });
                          } else {
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
                                    content: const Text("Not Same College"),
                                  ),
                                );
                              },
                            );
                          }
                        }else{
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
                                  content: const Text("Add atleast one badge of all kind"),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Join'),
                      shape: const CircleBorder(),
                      color: Colors.yellow,
                      elevation: 5,
                    )
                  ],
                ),
              ),
              CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                backgroundColor: Colors.black,
                radius: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
