import 'package:flutter/material.dart';

class BadgesButton extends StatelessWidget {

  final Function()? onPressed;
  final String label;

  const BadgesButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all<Color>(Colors.amberAccent)),
      onPressed: onPressed,
      child: Text(label,style: const TextStyle(color: Colors.white),),
    );
  }
}
