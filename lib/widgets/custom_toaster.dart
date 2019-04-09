import 'package:flutter/material.dart';


class CustomToaster {
  

  void showToast(BuildContext context, ToasterType type, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: type == ToasterType.success ? Colors.green: Colors.red,
        content: Text(message),
        //action: SnackBarAction(
        //  label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

enum ToasterType {

  success, failure
}