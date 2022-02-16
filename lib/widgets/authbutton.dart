import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {

  final String label;
  final Color color;
  final Function onPressed;
  final double height;


  const AuthenticationButton({Key? key, required this.label, required this.color, required this.onPressed, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:
        ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed: () { onPressed(); },
        child: Container(
          width: 100,
          height: height,
          child: Center(
            child: Text(
              label,
              style:
              TextStyle(fontSize: 18, color: color==Colors.white?Colors.black:Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(80))),
        ));
  }
}
