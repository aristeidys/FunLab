import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/listTile_with_arrow.dart';

@immutable
class Message {
  final String title;
  final String body;
  final ListTileType type;
  Message({
    @required this.title,
    @required this.body,
    @required this.type,
  });
}