import 'package:classmatesapp/modals/profile.dart';
import 'package:classmatesapp/widgets/badgesbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowBadgesPage extends StatefulWidget {
  final List<CircleAvatar> badges;
  const ShowBadgesPage({Key? key, required this.badges}) : super(key: key);

  @override
  _ShowBadgesPageState createState() => _ShowBadgesPageState();
}

class _ShowBadgesPageState extends State<ShowBadgesPage> {
  String getTitle(CircleAvatar circleAvatar) {
    if (circleAvatar.backgroundColor == Colors.green) {
      return 'Skill';
    } else if (circleAvatar.backgroundColor == Colors.yellow) {
      return 'Award';
    } else {
      return 'Jobs';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(border: Border.all()),
          child: widget.badges.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.badges.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: widget.badges[index],
                                title: Text(getTitle(widget.badges[index])),
                                subtitle: Text(Provider.of<Profile>(context)
                                    .badgesDesc[index]),
                              );
                            }),
                      ),
                      BadgesButton(onPressed: () => Navigator.pop(context), label: 'Go back?'),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
              )
              : const Center(
                  child: Text('No Badges to Show'),
                )),
    );
  }
}
