// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:funlab/models/lab_session.model.dart';
import 'package:funlab/services/service.dart';
import 'package:funlab/widgets/custom_form.dart';
import 'package:funlab/widgets/custom_future_list.dart';
import 'package:funlab/widgets/custom_toaster.dart';
import 'package:funlab/widgets/my_page_indicator.dart';

class HomePage extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      PageView(
        controller: pageController,
        children: <Widget>[
          MyCustomForm((labSessionTitle) {
            LabSession session =
                LabSession(title: labSessionTitle, finished: false);
            HttpService<LabSession>().postRequest(session, (success, id) {
              if (success) {
                CustomToaster().showToast(context, ToasterType.success,
                    'Session Created Successfully');
              } else {
                CustomToaster().showToast(
                    context, ToasterType.failure, 'Failure Creating Session');
              }
            });
          }, 'Enter Session Name'),
          CustomFutureList<LabSession>(
              HttpService<LabSession>().getAllLabSessions())
        ],
      ),
      MyPageIndicator(pageController: pageController)
    ]);
  }
}

// class IncreseButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, VoidCallback>(converter: (store) {
//       return () => store.dispatch(NextQuestionAction());
//     }, builder: (context, callback) {
//       return RaisedButton(child: Text('increse'), onPressed: callback);
//     });
//   }
// }

// class CustomText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, int>(
//       converter: (store) => store.state.questionIndex,
//       builder: (context, index) {
//         return Text(index.toString());
//       },
//     );
//   }
// }
