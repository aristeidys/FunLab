import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomForm extends StatelessWidget {
  String finalValue;
  final String labelText;
  final TextEditingController textFieldController = TextEditingController();
  final Function validator;

  CustomForm( this.labelText, this.validator);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textFieldController,
        decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  textFieldController.clear();
                })),
        onSaved: (String value) {
          finalValue = value;
          textFieldController.clear();
        },
        validator: validator);
  }
}
