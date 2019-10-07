// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/forms/custom_form.dart';
import 'package:funlab/common/widgets/forms/form_validators.dart';

typedef Null LoginCallback(String email, String password);

class LogInForm extends StatefulWidget {
  final LoginCallback callback;
  final String title;
  LogInForm(this.title, this.callback);

  @override
  LogInFormState createState() {
    return LogInFormState();
  }
}

class LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<CustomFormState>();
  final passwordKey = GlobalKey<CustomFormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Center(
              child: Text(widget.title),
            ),
            CustomForm(emailKey, 'Enter Email', FormValidators.email),
            CustomForm(passwordKey, 'Enter Password', FormValidators.password),
            Center(
                child: CreateButton('Submit', () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.callback(emailKey.currentState.finalValue,
                    passwordKey.currentState.finalValue);
              }
            })),
          ],
        ),
      ),
    );
  }
}
