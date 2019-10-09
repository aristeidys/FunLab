import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/state/reducers/messages_reducer.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/state/store.dart';

class FireBaseWidget extends StatefulWidget {
  final String channel;

  FireBaseWidget(this.channel);

  @override
  _FireBaseWidgetState createState() => _FireBaseWidgetState();
}

class _FireBaseWidgetState extends State<FireBaseWidget> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  List<FirebaseMessage> messages;

  Function setMessagesStateCallback;
  Function deleteMessagesStateCallback;

  @override
  void initState() {
    super.initState();
    firebaseMessaging.subscribeToTopic(widget.channel);
    this.configureFirebase();
  }

  @override
  void dispose() {
    deleteMessagesStateCallback('');
    firebaseMessaging.unsubscribeFromTopic(widget.channel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnStateChanged>(converter: (store) {
      return (messages) => store.dispatch(SetMessagesAction(messages));
    }, builder: (context, stateCallback) {
      setMessagesStateCallback = stateCallback;
      return StoreConnector<AppState, OnStateChanged>(converter: (store) {
        return (messages) => store.dispatch(DeleteMessagesAction());
      }, builder: (context, stateDeleteCallback) {
        deleteMessagesStateCallback = stateDeleteCallback;
        return StoreConnector<AppState, List<FirebaseMessage>>(
            converter: (store) => store.state.messages,
            builder: (context, stateMessages) {
              messages = stateMessages;
              return Container();
            });
      });
    });
  }

  void configureFirebase() {
    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch called $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume called $message');
      },
      onMessage: (Map<String, dynamic> message) async {
        handleMessage(message);
      },
    );
    firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
  }

  void handleMessage(Map<String, dynamic> message) {
    FirebaseMessage messageModel = FirebaseMessage.fromJson(message);
    print('onMessage called: $message');
    print('Message Model: $messageModel');

    messages.add(messageModel);
    print('All Messages : $messages');
    setMessagesStateCallback(messages);
  }
}
