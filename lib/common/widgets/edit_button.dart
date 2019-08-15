import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final String text;
  final Function callback;
  EditButton(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: callback,
      child: Text(text),
    );
  }
}
