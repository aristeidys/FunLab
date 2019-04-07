// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/actions/counter_actions.dart';
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
      body: Container(
        child: ListView(children: <Widget>[CustomText(), IncreseButton(), DecreseButton()]),
      ),
      // FloatingActionButton is literally a button that floats above
      // all other page content.
      floatingActionButton: FloatingActionButton(
        // Pass it a callback to execute when tapped
        onPressed: () => {}, // new
        // Pass it children to render in the button
        child: Icon(Icons.add), // new
      ),
    );
  }
}

class IncreseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(NextQuestionAction());
    }, builder: (context, callback) {
      return RaisedButton(child: Text('increse'), onPressed: callback);
    });
  }
}

class DecreseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(PreviousQuestionAction());
    }, builder: (context, callback) {
      return RaisedButton(child: Text('decrese'), onPressed: callback);
    });
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
