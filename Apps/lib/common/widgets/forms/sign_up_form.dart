// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';

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
  String _email;
  String _password;
  String _name;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            getNameFormWidget(),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            getEmailFormWidget(),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            getPasswordFormWidget(),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Center(
                child: CreateButton('Submit', () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.callback(_name, _email, _password);
              }
            })),
          ],
        ),
      ),
    );
  }

  TextFormField getNameFormWidget() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Enter Name',
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () {})),
        onSaved: (String value) {
          _name = value;
        },
        validator: (String email) {
          return email.length <= 6 ? 'Email too short.' : null;
        });
  }

  TextFormField getEmailFormWidget() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Enter Email',
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () {})),
        onSaved: (String value) {
          _email = value;
        },
        validator: (String email) {
          if (!email.contains('@')) {
            return 'Value too short.';
          } else if (email.length <= 6) {
            return 'Email too short.';
          }
        });
  }

  TextFormField getPasswordFormWidget() {
    return TextFormField(
        decoration: InputDecoration(
            labelText: 'Enter Password',
            filled: true,
            fillColor: Colors.white,
            suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: () {})),
        onSaved: (String value) {
          _password = value;
        },
        validator: (String email) {
          return email.length <= 6 ? 'Email too short.' : null;
        });
  }
}
