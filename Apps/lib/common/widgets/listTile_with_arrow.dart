import 'package:flutter/material.dart';

class ListTileWithArrow extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTapCallback;
  final IconData icon;

  const ListTileWithArrow({
    Key key,
    @required this.title,
    @required this.subTitle,
    @required this.onTapCallback,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(icon, color: Colors.white),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              //  Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Expanded(child: Text(subTitle, maxLines: 2, style: TextStyle(color: Colors.white)),) 
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            onTapCallback();
          },
        ),
      ),
    );
  }
}
