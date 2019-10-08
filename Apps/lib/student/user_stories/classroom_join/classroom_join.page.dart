import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/forms/form_with_button.dart';

class ClassroomJoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.studentMainColor,
        title: Text('Join a Classroom'),
      ),
      body: FormWithButton('Enter Classroom Name', 'Join Classroom', (name) {}),
    );
  }
}
