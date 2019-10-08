import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/task.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/services/special/googleApi.service.dart';
import 'package:funlab/common/stateManagment/app_state.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'package:http/http.dart';

class StudentTaskList extends StatefulWidget {
  final LabSession labSession;

  StudentTaskList({Key key, @required this.labSession}) : super(key: key);

  @override
  _StudentTaskListState createState() => _StudentTaskListState();
}

class _StudentTaskListState extends State<StudentTaskList> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  List<StudentTileViewModel> viewModels = [];
  String firebaseID;
  Future<List<Task>> _listFuture;

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.subscribeToTopic(Messaging.studentChannel);
    this.configureFirebase();
    _listFuture = updateAndGetList();
  }

  Future<List<Task>> updateAndGetList() async {
    // return TaskService()
    //     .getTasksWithSessionID(widget.labSession.id)
    //     .then((List<Task> values) {
    //   values.forEach((value) {
    //     viewModels.add(StudentTileViewModel(
    //         taskId: value.id,
    //         title: value.name,
    //         body: '',
    //         type: ListTileType.defaultTile));
    //   });
    //   return values;
    // });
  }

  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token is $token');
      firebaseID = token;
    });

    return StoreConnector<AppState, String>(
        converter: (store) => store.state.username,
        builder: (context, username) {
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
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  child: Container(
                                      color: Colors.white,
                                      child: StudentDefaultListTile(
                                        title: snapshot.data[position].name,
                                        subTitle: snapshot
                                            .data[position].sessionID
                                            .toString()                                      )),
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                        caption: 'Ask Help',
                                        color: Colors.yellow,
                                        icon: Icons.assignment_turned_in,
                                        onTap: () async {
                                          Response response =
                                              await sendHelpNotification(
                                                  context,
                                                  username,
                                                  snapshot.data[position]);
                                          CustomToaster().showDefaultToast(
                                              response, context);
                                        }),
                                    IconSlideAction(
                                      caption: 'Mark Done',
                                      color: Colors.green,
                                      icon: Icons.assignment,
                                      onTap: () async {
                                        Response response =
                                            await sendDoneNotification(
                                                context,
                                                username,
                                                snapshot.data[position]);
                                        CustomToaster().showDefaultToast(
                                            response, context);
                                      },
                                    ),
                                  ],
                                );
                              })
                          : Center(child: CircularProgressIndicator());
                    }
                  }));
        });
  }

  Future<Response> sendHelpNotification(
      BuildContext context, String username, Task task) async {
    return await Messaging().sendToTopic(
        title: 'A Student needs your Help',
        body: '$username needs help on ${task.name}',
        type: Messaging.messageTypeStudentHelp,
        topic: Messaging.instructorChannel,
        senderFCMID: firebaseID,
        username: username,
        taskId: task.id);
  }

  Future sendDoneNotification(
      BuildContext context, String username, Task task) async {
    return await Messaging().sendToTopic(
        title: 'A Student finished a Task',
        body: '$username finished ${task.name}',
        type: Messaging.messageTypeStudentDone,
        topic: Messaging.instructorChannel,
        senderFCMID: firebaseID,
        username: username,
        taskId: task.id);
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
