import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/instructor/components/instructor_forms.dart';

class InstructorHomePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Create a Session'),
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          InstructorForms()
        ]));
  }
}
