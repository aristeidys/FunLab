import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/task.service.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'done_action.dart';
import 'help_action.dart';

class StudentTaskList extends StatefulWidget {
  final Session session;
  StudentTaskList({Key key, this.session}) : super(key: key);

  @override
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State<StudentTaskList> {
  List<Task> tasks = [];
  String firebaseID;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return StoreConnector<AppState, String>(
              converter: (store) => store.state.token,
              builder: (context, token) {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Styles.studentMainColor,
                      title: Text('Session: ${widget.session.title}'),
                    ),
                    body: StoreConnector<AppState, User>(
                        converter: (store) => store.state.user,
                        builder: (context, student) {
                          return FutureBuilder<List<Task>>(
                              future: TaskService()
                                  .getTaskAndCreateTaskResultsIfNotExist(
                                      widget.session.id, student.id)
                                  .then((values) => tasks = values),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return new Text('Error: ${snapshot.error}');
                                } else {
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          padding: const EdgeInsets.all(15.0),
                                          itemBuilder: (context, position) {
                                            Task task = snapshot.data[position];
                                            return Slidable(
                                              actionPane:
                                                  SlidableDrawerActionPane(),
                                              actionExtentRatio: 0.25,
                                              child: Container(
                                                  color: Colors.white,
                                                  child:
                                                      StudentCompletedListTile(
                                                          title: task.name,
                                                          subTitle: '')),
                                              secondaryActions: <Widget>[
                                                new HelpWidget(
                                                    myContext: context,
                                                    task: task,
                                                    user: student,
                                                    token: token,
                                                    recipient:
                                                        '/topics/${classroom.name}'),
                                                new DoneWidget(
                                                    myContext: context,
                                                    task: task,
                                                    user: student,
                                                    token: token,
                                                    recipient:
                                                        '/topics/${classroom.name}'),
                                              ],
                                            );
                                          })
                                      : Center(
                                          child: CircularProgressIndicator());
                                }
                              });
                        }));
              });
        });
  }
}
