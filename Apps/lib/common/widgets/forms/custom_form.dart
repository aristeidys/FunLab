import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomForm extends StatefulWidget {
  final String labelText;
  final TextEditingController textFieldController = TextEditingController();
  final Function validator;

  CustomForm(Key key, this.labelText, this.validator)
      : super(key: key);

  CustomFormState createState() => CustomFormState();
}

class CustomFormState extends State<CustomForm> {
  String finalValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.textFieldController,
        decoration: InputDecoration(
            labelText: widget.labelText,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  widget.textFieldController.clear();
                })),
        onSaved: (String value) {
          finalValue = value;
          widget.textFieldController.clear();
        },
        validator: widget.validator);
  }
}
