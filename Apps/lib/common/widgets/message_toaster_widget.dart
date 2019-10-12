import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/common/models/message.model.dart';
import 'package:funlab/common/state/state.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class MessageObserverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, List<FirebaseMessage>>(
        converter: (store) => store.state.messages,
        builder: (context, messages) {
          CustomToaster()
              .showToast(context, ToasterType.message, messages.last.body);

          return Container();
        });
  }
}
