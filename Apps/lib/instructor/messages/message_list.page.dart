import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/state/reducers/messages_reducer.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/state/store.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';
import 'actions/help_given_action.dart';
import 'actions/pass_action.dart';
import 'actions/reject_action.dart';

class MessageListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, String>(
        converter: (store) => store.state.token,
        builder: (context, token) {
          return StoreConnector<AppState, List<FirebaseMessage>>(
              converter: (store) => store.state.messages,
              builder: (context, messages) {
                return StoreConnector<AppState, User>(
                    converter: (store) => store.state.user,
                    builder: (context, instructor) {
                      return StoreConnector<AppState, OnStateChanged>(
                          converter: (store) {
                        return (session) =>
                            store.dispatch(SetMessagesAction(messages));
                      }, builder: (context, callback) {
                        return Scaffold(
                            appBar: AppBar(
                              backgroundColor: Styles.instructorColor,
                              title: Text('All incoming Messages'),
                            ),
                            body: Column(children: <Widget>[
                              messages.length == 0
                                  ? Container(
                                      margin: EdgeInsets.only(top: 30),
                                      child: Center(
                                        child:
                                            Text('Messages will appear here'),
                                      ))
                                  : Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: messages.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            FirebaseMessage message =
                                                messages[index];
                                            return Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                actionExtentRatio: 0.25,
                                                child: Container(
                                                    color: Colors.white,
                                                    child: message.type ==
                                                            FirebaseMessage.done
                                                        ? InstructorDoneListTile(
                                                            title:
                                                                message.title,
                                                            subTitle:
                                                                message.body,
                                                          )
                                                        : InstructorHelpListTile(
                                                            title:
                                                                message.title,
                                                            subTitle:
                                                                message.body,
                                                          )),
                                                secondaryActions: message
                                                            .type ==
                                                        FirebaseMessage.help
                                                    ? <Widget>[
                                                        HelpGivenWidget(
                                                            myContext: context,
                                                            taskName: message
                                                                .taskName,
                                                            user: instructor,
                                                            token: token,
                                                            recipient:
                                                                '${message.senderToken}',
                                                            taskID:
                                                                message.taskID,
                                                            callback: () {
                                                              deleteMessage(
                                                                  callback,
                                                                  message,
                                                                  messages);
                                                            })
                                                      ]
                                                    : <Widget>[
                                                        PassWidget(
                                                            oldMessage: message,
                                                            myContext: context,
                                                            user: instructor,
                                                            token: token,
                                                            recipient:
                                                                '${message.senderToken}',
                                                            callback: () {
                                                              deleteMessage(
                                                                  callback,
                                                                  message,
                                                                  messages);
                                                            }),
                                                        RejectWidget(
                                                            myContext: context,
                                                            taskName: message
                                                                .taskName,
                                                            user: instructor,
                                                            token: token,
                                                            recipient:
                                                                '${message.senderToken}',
                                                            taskID:
                                                                message.taskID,
                                                            callback: () {
                                                              deleteMessage(
                                                                  callback,
                                                                  message,
                                                                  messages);
                                                            })
                                                      ]);
                                          }))
                            ]));
                      });
                    });
              });
        });
  }

  deleteMessage(
      callback, FirebaseMessage message, List<FirebaseMessage> messages) {
    List<FirebaseMessage> localMessages = messages;
    localMessages.remove(message);

    callback(localMessages);
  }
}
