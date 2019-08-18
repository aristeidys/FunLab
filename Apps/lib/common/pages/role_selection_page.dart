import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/pages/messages_view_page.dart';
import 'package:funlab/common/widgets/custom_texts.dart';
import 'package:funlab/common/widgets/messaging_widget.dart';
import 'package:funlab/instructor/pages/instructor_home_page.dart';

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
            color: Colors.red,
            icon: Icon(Icons.child_care),
            label: Text('Student'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentHomePage()),
              );
            },
        )),
        Center(
          child: FlatButton.icon(
            color: Colors.blue,
            icon: Icon(Icons.message),
            label: Text('Messages'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagingPage()),
              );
            },
        )),
        
      ],
    );
  }
}
