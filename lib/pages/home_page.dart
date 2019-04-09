import 'package:flutter/widgets.dart';
import 'package:funlab/components/instructor_forms.dart';
import 'package:funlab/models/lab_session.model.dart';
import 'package:funlab/services/service.dart';
import 'package:funlab/widgets/custom_future_list.dart';
import 'package:funlab/widgets/my_page_indicator.dart';

class HomePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      PageView(
        controller: pageController,
        children: <Widget>[
          InstructorForms(),
          CustomFutureList<LabSession>(
              HttpService<LabSession>().getAllLabSessions()),
        ],
      ),
      MyPageIndicator(pageController: pageController)
    ]);
  }
}
