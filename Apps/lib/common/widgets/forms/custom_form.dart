import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomForm extends StatefulWidget {
  final String labelText;
  final Function validator;

  CustomForm(Key key, this.labelText, this.validator)
      : super(key: key);

  CustomFormState createState() => CustomFormState();
}

class CustomFormState extends State<CustomForm> {
  String finalValue;
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textFieldController,
        decoration: InputDecoration(
            labelText: widget.labelText,
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
        validator: widget.validator);
  }
}
