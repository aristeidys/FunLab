
import 'package:flutter/widgets.dart';
import 'package:funlab/components/lab_session_form.dart';
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
          new LabSessionForm(),
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
