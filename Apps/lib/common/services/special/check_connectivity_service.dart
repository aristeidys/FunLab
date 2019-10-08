import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:funlab/common/widgets/custom_toaster.dart';

class CheckConnectivityService extends StatefulWidget {
  @override
  CheckConnectivityServiceState createState() {
    return CheckConnectivityServiceState();
  }
}

class CheckConnectivityServiceState extends State<CheckConnectivityService> {

  StreamSubscription<ConnectivityResult> subscription;

  @override
  Widget build(BuildContext context) {
    return Center();
  }

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.none:
          CustomToaster().showToast(context, ToasterType.failure, 'Check your internet connection');
          break;
        default:
          CustomToaster().showToast(context, ToasterType.success, 'Back Online');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

}