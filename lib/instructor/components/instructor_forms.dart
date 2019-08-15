import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/reducers/app_state.dart';
import 'package:funlab/common/services/lab_session.service.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';
import 'package:funlab/common/widgets/edit_button.dart';
import 'package:funlab/instructor/components/activity_form.dart';
import 'package:funlab/instructor/components/lab_session_form.dart';

class InstructorForms extends StatelessWidget {
  final pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
        converter: (store) => store.state.currentLabId,
        builder: (context, id) {
          return id < 0 ? 
          
          LabSessionForm() : 
          
          Column(children: <Widget>[
          
            ActivityForm(),

            EditButton('Publish Lab Session', (){
              Map<String, String> labSession = {'draft': 'false'};
                HttpService().putRequest(id, labSession, (success, id) {
                  if (success) {
                    CustomToaster().showToast(context, ToasterType.success,
                        'Lab Session with id=$id draft=true successful');
                  } else {
                    CustomToaster().showToast(context, ToasterType.failure,
                        'Lab Session with id=$id draft=true failed');
                  }
                });
            }) 
          ]);
        });
  }
}
