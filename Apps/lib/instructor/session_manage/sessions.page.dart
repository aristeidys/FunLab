import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/session.dart';
import 'package:funlab/common/services/classroom.service.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/state/reducers/session_reducer.dart';
import 'package:funlab/common/state/store.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

class SessionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return StoreConnector<AppState, OnStateChanged>(converter: (store) {
            return (session) => store.dispatch(SetSessionAction(session));
          }, builder: (context, callback) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Styles.instructorColor,
                  title: Text('All Sessions in ${classroom.name}'),
                ),
                body: AllSessionsList(classroom.id));
          });
        });
  }
}

class AllSessionsList extends StatefulWidget {
  final int classroomID;

  AllSessionsList(this.classroomID);

  @override
  AllSessionsListState createState() => AllSessionsListState();
}

class AllSessionsListState extends State<AllSessionsList> {
  List<Session> sessions = [];

  @override
  void initState() {
    super.initState();
    ClassroomService().getAllSessions(widget.classroomID).then((response) {
      if (response.error == null) {
        setState(() {
          sessions = response.data;
        });
      } else {
        CustomToaster().showToast(context, ToasterType.success,
            'Failed to fetch Sessions ${response.error}');
      }
    });
  }

  void removeAtIndex(int index) {
    setState(() {
      sessions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      sessions.length == 0
          ? Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Text('Sessions will appear here'),
              ))
          : Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: sessions.length,
                  itemBuilder: (BuildContext context, int index) {
                    Session session = sessions[index];
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                          color: Colors.white,
                          child: StudentDefaultListTile(
                              title: session.title, subTitle: session.status)),
                    );
                  }))
    ]);
  }
}
