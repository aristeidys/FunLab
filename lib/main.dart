// main.dart
import 'package:flutter/material.dart';
import 'package:funlab/models/lab_session.model.dart';
import 'package:funlab/services/service.dart';
import 'package:funlab/store.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/widgets/custom_form.dart';
import 'package:funlab/widgets/custom_future_list.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:funlab/widgets/my_page_indicator.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  final String title = 'Fun Lab';

  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    // Wrap your MaterialApp in a StoreProvider
    return StoreProvider(
        store: createStore(),
        child: MaterialApp(
            title: title,
            home: Scaffold(
                appBar: AppBar(
                  title: Text(this.title),
                ),
                body:
                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                  PageView(
                    controller: pageController,
                    children: <Widget>[
                      MyCustomForm((labSessionTitle) {
                        LabSession session =
                            LabSession(title: labSessionTitle, finished: false);
                        HttpService().postLabSession(session);
                      }, 'Enter Session Name'),
                      CustomFutureList<LabSession>(
                          HttpService().getLabSessions())
                    ],
                  ),
                  MyPageIndicator(pageController: pageController)
                ]))));
  }
}
