import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/student.model.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/student/components/find_student_form.dart';
import 'package:funlab/student/pages/student_enter_name.dart';
import 'package:funlab/student/pages/student_session_search.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final pageController = new PageController();

  final List<Student> students = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Log In'),
        ),
        body: Column(children: <Widget>[
          FindStudentForm(
            buttonCallback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentSessionSearchPage()),
              );
            },
          ),
          Center(
            child: Text('Or create new User...'),
          ),
          Center(
              child: EditButton(
            text: 'New User',
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentEnterNamePage()));
            },
          )),
        ]));
  }
}
