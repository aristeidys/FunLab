// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/create_button.dart';

class FormWithButton extends StatefulWidget {
  final Function callback;
  final String labelText;
  final String buttonText;

  FormWithButton(this.labelText, this.buttonText, this.callback);

  @override
  FormWithButtonState createState() {
    return FormWithButtonState();
  }
}

class FormWithButtonState extends State<FormWithButton> {
  final _formKey = GlobalKey<FormState>();
  String _value;
  TextEditingController _textFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Form(
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
            Padding(padding: EdgeInsets.all(5),),
            Center(
              child: 
              CreateButton(widget.buttonText, (){
                if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    widget.callback(_value);
                  }
              })
            ),
          ],
        ),
      ),
    );
  }
}
