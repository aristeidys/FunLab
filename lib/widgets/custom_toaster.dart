import 'package:flutter/material.dart';
import 'package:funlab/widgets/custom_texts.dart';

class NoInternetToaster {
  void show(BuildContext context) {
    CustomToaster().showToast(
        context, ToasterType.failure, 'Do you have access to the Internet?');
  }
}

class ServerErrorToaster {
  void show(BuildContext context) {
    CustomToaster().showToast(
        context, ToasterType.failure, 'Server not Available');
  }
}

class CustomToaster {
  void showToast(BuildContext context, ToasterType type, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor:
            type == ToasterType.success ? Colors.green : Colors.red,
        content: QuatedText(message),
        action: SnackBarAction(
          textColor: Colors.white,
         label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

enum ToasterType { success, failure }
