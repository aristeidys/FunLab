import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class MyPageIndicator extends StatelessWidget {
  const MyPageIndicator({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.all(20),
        child: PageIndicator(
          color: Colors.red,
          activeColor: Colors.blue,
          layout: PageIndicatorLayout.SLIDE,
          size: 20.0,
          controller: pageController,
          space: 5.0,
          count: 2,
        ));
  }
}
