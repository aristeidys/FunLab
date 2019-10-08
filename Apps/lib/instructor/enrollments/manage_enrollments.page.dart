import 'package:flutter/material.dart';
import 'package:funlab/common/styling.dart';
import 'package:funlab/common/widgets/buttons/edit_button.dart';
import 'package:funlab/instructor/enrollments/pending_enrollments.page.dart';

import 'active_enrollments.page.dart';

class ManageEnrollmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.instructorColor,
          title: Text('Manage Enrollments'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 10,
              ),
              EditButton(
                  'Active Enrollments',
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActiveEnrollmentsPage()),
                      )),
              EditButton(
                  'Pending Enrollments',
                  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PendingEnrollmentsPage()),
                      )),
            ],
          ),
        ));
  }
}
