import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/widgets/custom_texts.dart';
import 'package:funlab/instructor/pages/home.dart';
import 'package:funlab/instructor/pages/session_dashboard.dart';
import 'package:funlab/student/pages/student_enter_name.dart';

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: TitleText('Select your role'),
        ),
        Padding(padding: EdgeInsets.only(top: 40.0)),
        Center(
          child: FlatButton.icon(
            color: Colors.yellow,
            icon: Icon(Icons.book),
            label: Text('Instructor'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InstructorHomePage()),
              );
            },
          ),
        ),
        Center(
            child: FlatButton.icon(
          color: Colors.green,
          icon: Icon(Icons.school),
          label: Text('Student'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StudentEnterNamePage()),
            );
          },
        ))
      ],
    );
  }
}
