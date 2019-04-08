// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/actions/counter_actions.dart';
import 'package:funlab/models/app_state.dart';
import 'package:funlab/models/dataModel/lab_session.model.dart';
import 'package:funlab/models/service.dart';
import 'package:funlab/widgets/custom_form.dart';
import 'package:funlab/widgets/custom_future_list.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  final Function textInpuCallback = (_value) {
    LabSession session = LabSession(title: _value, finished: false);
    HttpService().postLabSession(session);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          MyCustomForm(textInpuCallback, 'Enter Session Name'),
          CustomFutureList<LabSession>(HttpService().getLabSessions()),
          CustomText(),
          IncreseButton()
        ]),
      ),
    );
  }
}

class IncreseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(NextQuestionAction());
    }, builder: (context, callback) {
      return RaisedButton(child: Text('increse'), onPressed: callback);
    });
  }
}

class CustomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) => store.state.questionIndex,
      builder: (context, index) {
        return Text(index.toString());
      },
    );
  }
}
