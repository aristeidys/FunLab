import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'package:funlab/student/components/find_lab_session_form.dart';
import 'package:funlab/student/pages/student_activity_list.dart';

class StudentSessionSearchPage extends StatefulWidget {
  @override
  _StudentSessionSearchPageState createState() =>
      _StudentSessionSearchPageState();
}

class _StudentSessionSearchPageState extends State<StudentSessionSearchPage> {
  final pageController = new PageController();

  final List<LabSession> sessions = [];
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Join a Session'),
        ),
        body: Column(children: <Widget>[
          FindLabSessionForm(
            callback: handleSessionResult,
          ),
          sessions.length == 0
              ? Text('Findings will appear here')
              : Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: sessions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTileWithArrow(
                          title: sessions[index].title,
                          subTitle:
                              '${sessions[index].finished ? 'Finished' : 'Not Finished'}',
                          type: ListTileType.doneTyle,
                          onTapCallback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentActivityList(
                                        labSession: sessions[index],
                                      )),
                            );
                          },
                        );
                      }))
        ]));
  }

  void handleSessionResult(List<LabSession> sessions) {
    setState(() {
      this.sessions.addAll(sessions);
    });
  }
}
