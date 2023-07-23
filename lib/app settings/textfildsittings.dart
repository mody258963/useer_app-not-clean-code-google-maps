import 'package:flutter/material.dart';

class FuckfIELD extends StatelessWidget {
  final String? Function(String?) val;
  final TextEditingController controllerr;
  final String text;
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();
  FuckfIELD({
    super.key,
    required this.text,
    required this.controllerr,
    required this.val,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controllerr,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          hintText: text,
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide.none),
        ),
        validator: val);
  }
}
