import 'package:flutter/material.dart';

class DummyText2 extends StatelessWidget {
  final String text1;
  final Widget icon1;
  const DummyText2(
      {Key? key,
      required this.text1,
      required this.icon1,
      required String text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(child: icon1),
            TextSpan(
                text: text1,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
