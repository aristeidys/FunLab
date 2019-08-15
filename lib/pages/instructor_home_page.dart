import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/components/instructor_forms.dart';
import 'package:funlab/models/assignment.model.dart';
import 'package:funlab/models/lab_session.model.dart';
import 'package:funlab/services/activity.service.dart';
import 'package:funlab/services/service.dart';
import 'package:funlab/widgets/custom_future_list.dart';
import 'package:funlab/widgets/my_page_indicator.dart';

class InstructorHomePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Instructor'),
        ),
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          PageView(
            controller: pageController,
            children: <Widget>[
              InstructorForms(),
              CustomFutureList<LabSession>(
                  HttpService<LabSession>().getAllLabSessions(context)),
              CustomFutureList<Activity>(ActivityService().getAllActivities()),
            ],
          ),
          MyPageIndicator(pageController: pageController)
        ]));
  }
}
