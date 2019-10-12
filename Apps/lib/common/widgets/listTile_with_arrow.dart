import 'package:flutter/material.dart';
import 'package:funlab/common/helpers/styling.dart';

enum ListTileType { helpTile, doneTile, defaultTile }

class StudentDefaultListTile extends ListTileWithArrow {
  StudentDefaultListTile({
    Key key,
    @required title,
    @required subTitle,
    onTapCallback,
  }) : super(
            title: title,
            subTitle: subTitle,
            colour: Styles.studentDefaultTileColour,
            icon: Icons.assignment,
            onTapCallback: onTapCallback);
}

class StudentRejectedListTile extends ListTileWithArrow {
  StudentRejectedListTile({
    Key key,
    @required title,
    @required subTitle,
  }) : super(
            title: title,
            subTitle: subTitle,
            colour: Styles.studentRejectedTileColour,
            icon: Icons.assignment_late);
}

class StudentCompletedListTile extends ListTileWithArrow {
  StudentCompletedListTile({
    Key key,
    @required title,
    @required subTitle,
  }) : super(
            title: title,
            subTitle: subTitle,
            colour: Styles.studentDoneTileColour,
            icon: Icons.assignment_turned_in,
            iconText: 'Done');
}

class StudentLockedListTile extends ListTileWithArrow {
  StudentLockedListTile({
    Key key,
  }) : super(
            title: 'Hidden',
            subTitle: 'Solve previous Task to see this',
            colour: Styles.studentHiddenTileColour,
            icon: Icons.content_paste,
            iconText: 'Hidden');
}

class StudentReadyListTile extends ListTileWithArrow {
  StudentReadyListTile({
    Key key,
    @required title,
    @required subTitle,
  }) : super(
            title: title,
            subTitle: subTitle,
            colour: Styles.studentDefaultTileColour,
            icon: Icons.assignment,
            iconText: 'Open');
}

class InstructorDoneListTile extends ListTileWithArrow {
  InstructorDoneListTile({
    Key key,
    @required title,
    @required subTitle,
  }) : super(
            title: title,
            subTitle: subTitle,
            colour: Colors.deepOrange,
            icon: Icons.done);
}

class InstructorHelpListTile extends ListTileWithArrow {
  InstructorHelpListTile({
    Key key,
    @required title,
    @required subTitle,
  }) : super(
            title: title,
            subTitle: subTitle,
            colour: Color.fromRGBO(64, 75, 96, .9),
            icon: Icons.live_help);
}

class ListTileWithArrow extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTapCallback;
  final Color colour;
  final IconData icon;
  final String iconText;

  const ListTileWithArrow(
      {Key key,
      @required this.title,
      @required this.subTitle,
      this.onTapCallback,
      @required this.colour,
      @required this.icon,
      this.iconText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: colour),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Column(
              children: <Widget>[
                Icon(icon, color: Colors.white),
                Container(
                  height: 10,
                  width: 45,
                ),
                iconText != null
                    ? Text(
                        iconText,
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(''),
              ],
            ),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                child: Text(subTitle,
                    maxLines: 2, style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          trailing: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
          onTap: () {
            if (onTapCallback != null) {
              onTapCallback();
            }
          },
        ),
      ),
    );
  }
}
