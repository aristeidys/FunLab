import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/student/components/enter_name_form.dart';
import 'package:funlab/student/pages/student_session_search.dart';

class StudentEnterNamePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Create User'),
        ),
        body: EnterNameForm(
          buttonCallback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentSessionSearchPage()),
            );
          },
        ));
  }
}
