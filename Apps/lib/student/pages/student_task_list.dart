import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/services/task.service.dart';
import 'package:funlab/common/services/googleApi.service.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'package:funlab/student/pages/student_task_detail.dart';

class StudentTaskList extends StatefulWidget {
  final LabSession labSession;

  StudentTaskList({Key key, @required this.labSession}) : super(key: key);

  @override
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State<StudentTaskList> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<StudentTileViewModel> viewModels = [];

  Future<List<Task>> _listFuture;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.subscribeToTopic(Messaging.studentChannel);
    this.configureFirebase();
    _listFuture = updateAndGetList();
  }

  Future<List<Task>> updateAndGetList() async {
    return TaskService()
        .getTasksWithSessionID(widget.labSession.id)
        .then((List<Task> values) {
      values.forEach((value) {
        viewModels.add(StudentTileViewModel(
            taskId: value.id,
            title: value.title,
            body: '',
            type: ListTileType.defaultTile));
      });
      return values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.studentMainColor,
          title: Text('Session: ${widget.labSession.title}'),
        ),
        body: FutureBuilder<List<Task>>(
            future: _listFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                          return StudentDefaultListTile(
                            title: snapshot.data[position].title,
                            subTitle:
                                snapshot.data[position].labSessionId.toString(),
                            onTapCallback: () {
                              onTileTap(context, snapshot, position);
                            },
                          );
                        })
                    : Center(child: CircularProgressIndicator());
              }
            }));
  }

  void onTileTap(BuildContext context, AsyncSnapshot<List<Task>> snapshot,
      int position) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                StudentTaskDetail(task: snapshot.data[position])));
  }

  @override
  void dispose() {
    _firebaseMessaging.unsubscribeFromTopic(Messaging.studentChannel);
    super.dispose();
  }

  void configureFirebase() {
    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume called $message');
      },
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage called for Student $message');

        // uncomment to use fcm id of student
        //  String id = message['data']['senderFCMID'];
        String taskTitle = message['notification']['title'];

        String stringType = message['data'][Messaging.messageTypeKey];

        int taskId = int.parse(message['data'][Messaging.taskIdKey]);

        String messageType = stringType;

        String taskBody = message['notification']['body'];

        // setState(() {
        //   model.add(StudentTileViewModel(
        //       title: taskTitle,
        //       body: taskBody,
        //       type: messageType,
        //       taskId: taskId));
        // });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('Hello');
    });
  }
}
