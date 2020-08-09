import 'package:flutter/material.dart';

import 'package:appbar_examples/app/widget/appBars/homePageFloatingAppBar.dart';

import 'package:appbar_examples/others/sizeConfig.dart';

class Example1 extends StatefulWidget {
  @override
  _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool isInnerBoxScroll) {
          return [
            HomePageFloatingAppBar(),
          ];
        },
        body: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          color: Colors.blueAccent,
          child: ListView.builder(
            itemCount: 25,
            itemBuilder: (_, i) => ListTile(
              title: Text(
                "Title $i",
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: Colors.white,
                      fontSize: 5.0 * SizeConfig.widthMultiplier,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
