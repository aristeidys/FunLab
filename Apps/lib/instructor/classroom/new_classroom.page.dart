import 'package:flutter/material.dart';
import 'package:funlab/common/styling.dart';
import 'classroom_form.dart';

class ClassroomCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create Classroom'),
        ),
        body: Column(children: <Widget>[
          ClassroomForm()
        ]));
  }
}
