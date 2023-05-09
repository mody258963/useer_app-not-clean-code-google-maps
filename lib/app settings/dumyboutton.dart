import 'package:flutter/material.dart';

class Xbutton extends StatelessWidget {
  final String text;
  final Widget icons;
  final Widget page;
  const Xbutton({Key? key, required this.text, required this.icons, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> page));
      },
      label: Text(
        text,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
            fontSize: 22),
      ),
      icon: icons,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        maximumSize: const Size(600, 65),
        minimumSize: const Size(600, 65),
      ),
    );
  }
}
