import 'package:flutter/material.dart';

class Xbutton extends StatelessWidget {
  final String text;
  final Widget icons;
  final Future page;
  const Xbutton(
      {Key? key, required this.text, required this.icons, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.77,
      child: ElevatedButton(
        onPressed: () => page,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.horizontal(left: Radius.zero, right: Radius.zero),
          ),
          backgroundColor: Colors.black,
        ),
        child: Text(
          text,
          textAlign: TextAlign.end,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
