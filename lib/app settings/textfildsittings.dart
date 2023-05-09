import 'package:flutter/material.dart';

class FuckfIELD extends StatelessWidget {
  final dynamic validatore;
  final dynamic validatore2;
  final String erormassge;
  final String erormassge2;
  final dynamic omsaved;
  final String text;
  const FuckfIELD({
    super.key,
    required this.text,
    required this.validatore,
    required this.erormassge,
    this.validatore2,
    required this.erormassge2,
    this.omsaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (val) {
        omsaved;
      },
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        hintText: text,
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
            borderSide: BorderSide.none),
      ),
      validator: (ValueKey) {
        if (validatore) {
          return erormassge;
        }

        if (validatore2) {
          return erormassge2;
        }
        return null;
      },
    );
  }
}
