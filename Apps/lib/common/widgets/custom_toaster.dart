import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/custom_texts.dart';
import 'package:http/http.dart';

class NoInternetToaster {
  void show(BuildContext context) {
    CustomToaster().showToast(
        context, ToasterType.failure, 'Do you have access to the Internet?');
  }
}

class ServerErrorToaster {
  void show(BuildContext context) {
    CustomToaster()
        .showToast(context, ToasterType.failure, 'Server not Available');
  }
}

class CustomToaster {
  void showDefaultToast(Response response, BuildContext context) {
    if (response.statusCode != 200 && response.statusCode != 201) {
      CustomToaster().showToast(
          context, ToasterType.failure, 'Error sending Request. Try again.');
    } else {
      CustomToaster()
          .showToast(context, ToasterType.success, 'Sent successfully!');
    }
  }

  void showToast(BuildContext context, ToasterType type, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: getColor(type),
        content: QuatedText(message),
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'Close',
            onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Color getColor(ToasterType type) {
    if (type == ToasterType.success) {
      return Colors.green;
    } else if (type == ToasterType.failure) {
      return Colors.red;
    } else {
      return Colors.blue;
    }
  }
}

enum ToasterType { success, failure, message }
