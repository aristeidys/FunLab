import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/student/components/enter_name_form.dart';

class StudentEnterNamePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create User'),
        ),
        body: EnterNameForm());
  }
}
