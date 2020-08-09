import 'package:flutter/material.dart';

import 'package:appbar_examples/others/styling.dart';
import 'package:appbar_examples/others/sizeConfig.dart';

class Example2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            // ************************** ************************** ************************** **************************

            SliverAppBar(
              floating: true,
              expandedHeight: MyAppBarTheme.MobilePortraitHeight,
              flexibleSpace: Container(
                color: MyAppBarTheme.BackgroundColor,
                child: Material(
                  elevation: MyAppBarTheme.Elevation,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.safeTop,
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // ************************** **************************
                        /// Title

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Example 2",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.display1.copyWith(
                              color: MyAppBarTheme.TextColor,
                              fontSize: MyAppBarTheme.MobileTextSize,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.0,
                                  color: Colors.black.withOpacity(0.20),
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ************************** **************************
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ************************** ************************** ************************** **************************

            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      'Item #${index + 1}',
                      style: Theme.of(context).textTheme.display2.copyWith(
                            color: Color.fromARGB(255, 48, 48, 48),
                            fontSize: 4.0 * SizeConfig.widthMultiplier,
                          ),
                    ),
                  );
                },
                childCount: 1000,
              ),
            ),

            // ************************** ************************** ************************** **************************
          ],
        ),
      ),
    );
  }
}
