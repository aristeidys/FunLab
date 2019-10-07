// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/forms/custom_form.dart';

typedef Null LoginCallback(String email, String password);

class LogInForm extends StatefulWidget {
  final LoginCallback callback;

  LogInForm(this.callback);

  @override
  LogInFormState createState() {
    return LogInFormState();
  }
}

class LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomForm('Enter Email', (String email) {
              !email.contains('@') ? 'Value too short.' : null;
              email.length <= 6 ? 'Email too short.' : null;
            }),
            CustomForm('Enter Password', (String password) {
              password.length <= 6 ? 'Password too short.' : null;
            }),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Center(
                child: CreateButton('Submit', () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // widget.callback(emailKey.currentState.finalValue,
                //     passwordKey.currentState.finalValue);
              }
            })),
          ],
        ),
      ),
    );
  }
}
