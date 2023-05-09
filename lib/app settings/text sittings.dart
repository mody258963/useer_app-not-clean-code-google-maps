import 'package:flutter/material.dart';

class DummyText extends StatelessWidget {
  final String text;
  final double size;
  const DummyText({Key? key, required this.text, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}
