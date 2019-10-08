import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/styling.dart';

class StudentEnterNamePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Create User'),
        ),
        body: Container());
  }
}
