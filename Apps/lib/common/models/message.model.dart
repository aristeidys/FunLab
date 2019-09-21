import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

@immutable
class StudentMessage {
  final String title;
  final String body;
  final String studentToken;
  final ListTileType type;
  final int taskId;

  StudentMessage(
      {@required this.title,
      @required this.body,
      @required this.studentToken,
      @required this.type,
      @required this.taskId});
}

class StudentTileViewModel {
  final String title;
  final String body;
  final ListTileType type;
  final int taskId;

  StudentTileViewModel(
      {@required this.title,
      @required this.body,
      @required this.type,
      @required this.taskId});
}
