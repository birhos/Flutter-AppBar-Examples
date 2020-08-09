import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:appbar_examples/app/example1.dart';
import 'package:appbar_examples/app/example2.dart';
import 'package:appbar_examples/app/example3.dart';

import 'package:appbar_examples/others/styling.dart';
import 'package:appbar_examples/others/sizeConfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    // Forcing Only Portrait Orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            SizeConfig().init(constraints, orientation);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.darkTheme,
              title: 'Floating AppBar Example',
              home: SettingsPage(),
            );
          },
        );
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.safeTop = MediaQuery.of(context).padding.top;
    SizeConfig.safeBottom = MediaQuery.of(context).padding.bottom;
    SizeConfig.safeLeft = MediaQuery.of(context).padding.left;
    SizeConfig.safeRight = MediaQuery.of(context).padding.right;

    return Example3();
  }
}
