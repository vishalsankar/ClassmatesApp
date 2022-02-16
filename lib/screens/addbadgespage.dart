import 'package:classmatesapp/modals/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBadgesPage extends StatefulWidget {
  const AddBadgesPage({Key? key}) : super(key: key);

  @override
  _AddBadgesPageState createState() => _AddBadgesPageState();
}

class _AddBadgesPageState extends State<AddBadgesPage> {
  int badgeType = 1;

  late String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 2)),
          margin: const EdgeInsets.all(30.0),
          height: MediaQuery.of(context).size.height * 8,
          width: MediaQuery.of(context).size.width * 8,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Badge Type :',
                  style: TextStyle(fontSize: 24),
                ),
                RadioListTile<int>(
                  title: Text(
                    'Skills',
                    style: TextStyle(fontSize: 20),
                  ),
                  value: 1,
                  groupValue: badgeType,
                  onChanged: (value) {
                    setState(() {
                      badgeType = value!;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Awards', style: TextStyle(fontSize: 20)),
                  value: 2,
                  groupValue: badgeType,
                  onChanged: (value) {
                    setState(() {
                      badgeType = value!;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Jobs Held', style: TextStyle(fontSize: 20)),
                  value: 3,
                  groupValue: badgeType,
                  onChanged: (value) {
                    setState(() {
                      badgeType = value!;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Add Details:',
                  style: TextStyle(fontSize: 24),
                ),
                TextField(
                  style: TextStyle(fontSize: 22),
                  decoration: const InputDecoration(
                    hintText: 'Type here...',
                  ),
                  maxLines: 6,
                  onChanged: (value){
                    setState(() {
                      description=value;
                    });
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: TextButton(
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: (){
                      Provider.of<Profile>(context,listen: false).addBadge(badgeType, description);
                      Navigator.pop(context);
                    },
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
