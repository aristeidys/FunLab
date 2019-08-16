import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:funlab/common/models/assignment.model.dart';
import 'package:funlab/common/models/lab_session.model.dart';
import 'package:funlab/common/services/activity.service.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/custom_future_list.dart';
import 'package:funlab/common/widgets/my_page_indicator.dart';
import 'package:funlab/instructor/components/instructor_forms.dart';

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
                  LabSessionService().getAllLabSessions(context)),
              CustomFutureList<Activity>(ActivityService().getAllActivities()),
            ],
          ),
          MyPageIndicator(pageController: pageController)
        ]));
  }
}
