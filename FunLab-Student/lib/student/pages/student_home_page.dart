import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/student/components/find_lab_session_form.dart';

class StudentHomePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Join a Session'),
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          FindLabSessionForm()
        ]));
  }
}
