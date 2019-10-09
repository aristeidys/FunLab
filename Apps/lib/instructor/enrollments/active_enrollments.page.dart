import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:funlab/common/models/classroom.model.dart';
import 'package:funlab/common/models/user.model.dart';
import 'package:funlab/common/services/enrollment.service.dart';
import 'package:funlab/common/stateManagment/state.dart';
import 'package:funlab/common/helpers/styling.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

class ActiveEnrollmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Classroom>(
        converter: (store) => store.state.classroom,
        builder: (context, classroom) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Styles.instructorColor,
                title: Text('Active Enrollments'),
              ),
              body: FutureBuilder<List<User>>(
                  future: EnrollmentService().getAllApproved(classroom.id),
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
                                              .data[position].email
                                              .toString())),
                                );
                              })
                          : Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Center(
                                child: Text(
                                    'Student active enrollments will appear here'),
                              ));
                    }
                  }));
        });
  }
}
