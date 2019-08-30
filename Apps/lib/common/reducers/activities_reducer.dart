
import 'package:funlab/common/models/assignment.model.dart';

class ReplaceActivitiesAction {
  final List<Activity> activities;

  ReplaceActivitiesAction(this.activities);
}

class ToggleActivityStateAction {
  final Activity activity;

  ToggleActivityStateAction(this.activity);
}

typedef OnStateChanged = Function(dynamic);

List<Activity> activitiesReducer(List<Activity> activities, action) {
  if (action is ReplaceActivitiesAction) {
    return action.activities;
  } else {
    return activities;
  }
}

List<Activity> toggleActivityState(
    List<Activity> items, ToggleActivityStateAction action) {
  List<Activity> itemsNew = items
      .map((activity) =>
          activity.title == action.activity.title ? action.activity : activity)
      .toList();
  return itemsNew;
}