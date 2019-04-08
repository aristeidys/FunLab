// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:funlab/actions/counter_actions.dart';
import 'package:funlab/models/app_state.dart';
import 'package:funlab/models/dataModel/lab_session.model.dart';
import 'package:funlab/models/service.dart';
import 'package:http/http.dart' as http;

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
        child: ListView(children: <Widget>[
          CustomText(),
          IncreseButton(),
          buildFutureBuilder(HttpService().fetchLabSessions())
        ]),
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

Widget buildFutureBuilder(Future<List<LabSession>> method) {
  return FutureBuilder<List<LabSession>>(
    future: method,
    builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);

      return snapshot.hasData
          ? ListViewPosts(labSessions: snapshot.data)
          : Center(child: CircularProgressIndicator());
    },
  );
}

class ListViewPosts extends StatelessWidget {
  final List<LabSession> labSessions;

  ListViewPosts({Key key, this.labSessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: labSessions.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                    title: Text('${labSessions[position].title}'),
                    subtitle: Text('${labSessions[position].finished}'))
              ]);
            }));
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
