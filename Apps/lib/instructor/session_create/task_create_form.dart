import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/buttons/create_button.dart';
import 'package:funlab/common/widgets/forms/custom_form.dart';
import 'package:funlab/common/widgets/forms/form_validators.dart';
import 'package:funlab/common/widgets/forms/number_form.dart';

typedef Null TaskCreateCallback(String name, int difficulty);

class TaskCreateForm extends StatefulWidget {
  final TaskCreateCallback callback;

  TaskCreateForm(this.callback);

  @override
  TaskCreateFormState createState() {
    return TaskCreateFormState();
  }
}

class TaskCreateFormState extends State<TaskCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<CustomFormState>();
  final difficultyKey = GlobalKey<NumberFormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text('Create new Task'),
            CustomForm(nameKey, 'Enter Name', TaskValidators.name),
            NumberForm(difficultyKey, 'Enter Difficulty',
                TaskValidators.difficulty),
            Center(
                child: CreateButton('Add', () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                widget.callback(
                  nameKey.currentState.finalValue,
                  int.parse(difficultyKey.currentState.finalValue),
                );
              }
            })),
          ],
        ),
      ),
    );
  }
}
