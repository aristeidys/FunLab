// Create a Form Widget
import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  final Function callback;
  final String labelText;

  MyCustomForm(this.callback, this.labelText);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String _value;
  TextEditingController _textFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textFieldController,
            decoration: InputDecoration(
                labelText: widget.labelText,
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textFieldController.clear();
                    })),
            onSaved: (String value) {
              _value = value;
              _textFieldController.clear();
            },
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  widget.callback(_value);
                }
              },
              child: Text('Create'),
            ),
          ),
        ],
      ),
    );
  }
}
