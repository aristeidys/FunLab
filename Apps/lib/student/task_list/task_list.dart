import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/task_result.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/task.service.dart';
import 'package:funlab/common/services/task_result.service.dart';
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

class Merged {
  final List<Task> tasks;
  final List<TaskResult> taskResults;

  Merged({this.tasks, this.taskResults});
}

class _StudentTaskListState extends State<StudentTaskList> {
  int lastCompletedIndex = -1;

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
                          return FutureBuilder(
                              future: Future.wait([
                                TaskService()
                                    .getTaskAndCreateTaskResultsIfNotExist(
                                        widget.session.id, student.id),
                                TaskResultService()
                                    .get(student.id, widget.session.id)
                              ]).then((response) => new Merged(
                                  tasks: response[0],
                                  taskResults: response[1])),
                              builder:
                                  (context, AsyncSnapshot<Merged> snapshot) {
                                if (snapshot.hasError) {
                                  return new Text('Error: ${snapshot.error}');
                                } else {
                                  return snapshot.hasData
                                      ? ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data.taskResults.length,
                                          padding: const EdgeInsets.all(15.0),
                                          itemBuilder: (context, position) {
                                            TaskResult taskResult = snapshot
                                                .data.taskResults[position];
                                            Task task =
                                                snapshot.data.tasks[position];

                                            return Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                actionExtentRatio: 0.25,
                                                child: Container(
                                                    color: Colors.white,
                                                    child: buildListTile(
                                                        task,
                                                        taskResult,
                                                        position,
                                                        snapshot
                                                            .data
                                                            .taskResults
                                                            .length)),
                                                secondaryActions: position ==
                                                        lastCompletedIndex + 1
                                                    ? <Widget>[
                                                        HelpWidget(
                                                            myContext: context,
                                                            task: task,
                                                            user: student,
                                                            token: token,
                                                            recipient:
                                                                '/topics/${classroom.name}'),
                                                        DoneWidget(
                                                            myContext: context,
                                                            task: task,
                                                            user: student,
                                                            token: token,
                                                            recipient:
                                                                '/topics/${classroom.name}'),
                                                      ]
                                                    : <Widget>[]);
                                          })
                                      : Center(
                                          child: CircularProgressIndicator());
                                }
                              });
                        }));
              });
        });
  }

  ListTileWithArrow buildListTile(
      Task task, TaskResult taskResult, int index, int allTasks) {
    if (taskResult.completed) {
      lastCompletedIndex = index;
      return StudentCompletedListTile(
          title: task.name, subTitle: "");
    } else if (lastCompletedIndex + 1 == index) {
      return StudentReadyListTile(
          title: task.name, subTitle: "");
    } else {
      return StudentLockedListTile();
    }
  }
}
