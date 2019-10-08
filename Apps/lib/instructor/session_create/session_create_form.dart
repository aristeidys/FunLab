// Create a Form Widget
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/common/widgets/forms/custom_form.dart';
import 'package:funlab/common/widgets/forms/form_validators.dart';

typedef Null SessionCreateCallback(String title, String description);

class SessionCreateForm extends StatefulWidget {
  final SessionCreateCallback callback;

  SessionCreateForm(this.callback);

  @override
  SessionCreateFormState createState() {
    return SessionCreateFormState();
  }
}

class SessionCreateFormState extends State<SessionCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final titleKey = GlobalKey<CustomFormState>();
  final descriptionKey = GlobalKey<CustomFormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Create new Session'),
            CustomForm(titleKey, 'Enter Title', FormValidators.name),
            CustomForm(
                descriptionKey, 'Enter Description', FormValidators.email),
            Center(
                child: EditButton('Next', () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.callback(
                  titleKey.currentState.finalValue,
                  descriptionKey.currentState.finalValue,
                );
              }
            })),
          ],
        ),
      ),
    );
  }
}
