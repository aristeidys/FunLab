// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/forms/custom_form.dart';
import 'package:funlab/common/widgets/forms/form_validators.dart';

typedef Null SignUpCallback(String name, String email, String password);

class SignUpForm extends StatefulWidget {
  final SignUpCallback callback;

  SignUpForm(this.callback);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<CustomFormState>();
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
            CustomForm(nameKey, 'Enter Name', FormValidators.name),
            CustomForm(emailKey, 'Enter Email', FormValidators.email),
            CustomForm(passwordKey, 'Enter Password', FormValidators.password),
            Center(
                child: CreateButton('Submit', () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.callback(
                    nameKey.currentState.finalValue,
                    emailKey.currentState.finalValue,
                    passwordKey.currentState.finalValue);
              }
            })),
          ],
        ),
      ),
    );
  }
}
