import 'package:flutter/material.dart';
import 'package:funlab/components/assignment_form.dart';
import 'package:funlab/components/lab_session_form.dart';

class InstructorForms extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[LabSessionForm(), ActivityForm()]);
  }
}
