import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final String text;
  final Function callback;
  CreateButton(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.green,
      onPressed: callback,
      child: Text(text),
    );
  }
}
