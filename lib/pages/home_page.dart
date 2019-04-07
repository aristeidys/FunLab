// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/models/app_state.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar class takes a Widget for title, not a string
      // In order to get it to display our title, pass it a Text widget
      appBar: AppBar(
        title: Text(this.title), // new
      ),
      body: Container(child: CustomText(),),
      // FloatingActionButton is literally a button that floats above
      // all other page content.
      floatingActionButton: FloatingActionButton(
        // Pass it a callback to execute when tapped
        onPressed: () => print('PRESSED!'), // new
        // Pass it children to render in the button
        child: Icon(Icons.add), // new
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) => store.state.questionIndex,
      builder: (context, index) {
        return Text(index.toString());
      },
    );
  }
}
