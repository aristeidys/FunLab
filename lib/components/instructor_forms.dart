import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/components/activity_form.dart';
import 'package:funlab/components/lab_session_form.dart';
import 'package:funlab/reducers/app_state.dart';

class InstructorForms extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
        converter: (store) => store.state.currentLabId,
        builder: (context, id) {
          return id < 0 ? LabSessionForm() : ActivityForm();
        });
  }
}
