
import 'package:funlab/common/models/lab_session.model.dart';

class ReplaceCurrentLabAction {
  final LabSession currentLabSession;

  ReplaceCurrentLabAction(this.currentLabSession);
}

LabSession labSessionReducer(LabSession currentLabSession, action) {
  if (action is ReplaceCurrentLabAction) {
    return action.currentLabSession;
  } else {
    return currentLabSession;
  }
}
