import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/pages/instructor_home_page.dart';
import 'package:funlab/pages/student_home_page.dart';

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: FlatButton.icon(
            color: Colors.yellow,
            icon: Icon(Icons.book),
            label: Text('As Instructor'),
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
            color: Colors.red,
            icon: Icon(Icons.child_care),
            label: Text('As Student'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentHomePage()),
              );
            },
        ))
      ],
    );
  }
}
