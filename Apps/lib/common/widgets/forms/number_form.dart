import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NumberForm extends StatefulWidget {
  final String labelText;
  final Function validator;

  NumberForm(Key key, this.labelText, this.validator) : super(key: key);

  NumberFormState createState() => NumberFormState();
}

class NumberFormState extends State<NumberForm> {
  String finalValue;
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
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
