import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/session.service.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'done_action.dart';
import 'help_action.dart';

class StudentTaskList extends StatefulWidget {
  final int localSessionID;
  StudentTaskList({Key key, this.localSessionID}) : super(key: key);

  @override
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State<StudentTaskList> {
  Session localSession;
  List<Task> tasks = [];
  String firebaseID;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Session>(
        converter: (store) => store.state.session,
        builder: (context, session) {
          localSession = session;
          return StoreConnector<AppState, String>(
              converter: (store) => store.state.token,
              builder: (context, token) {
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Styles.studentMainColor,
                      title: Text('Session: ${session.title}'),
                    ),
                    body: StoreConnector<AppState, User>(
                        converter: (store) => store.state.user,
                        builder: (context, user) {
                          return FutureBuilder<List<Task>>(
                              future: SessionService()
                                  .getTasks(session.id)
                                  .then((values) => tasks = values),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return new Center(
                                    child: new CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
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
                                                  child: StudentDefaultListTile(
                                                      title: task.name,
                                                      subTitle: task.sessionID
                                                          .toString())),
                                              secondaryActions: <Widget>[
                                                new HelpWidget(
                                                  task: task,
                                                  user: user,
                                                  token: token,
                                                ),
                                                new DoneWidget(
                                                  task: task,
                                                  user: user,
                                                  token: token,
                                                ),
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
