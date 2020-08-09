import 'sizeConfig.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Private Constructor
  AppTheme._();

  /*static final myPageTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    },
  );*/

  static final ThemeData darkTheme = ThemeData(
    //pageTransitionsTheme: myPageTransitions,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
    textSelectionColor: Colors.black,
    textSelectionHandleColor: Colors.white,
  );

  static final TextTheme darkTextTheme = TextTheme(
    title: _titleDark,
    display1: _display1Dark,
    display2: _display2Dark,
  );

  static final TextStyle _titleDark = TextStyle(
    color: Colors.black,
    fontSize: 3.5 * SizeConfig.widthMultiplier,
  );

  static final TextStyle _display1Dark = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 2.5 * SizeConfig.widthMultiplier,
    color: Colors.black,
  );

  static final TextStyle _display2Dark = TextStyle(
    fontFamily: 'Adelle_Regular',
    fontWeight: FontWeight.w600,
    fontSize: 2.5 * SizeConfig.widthMultiplier,
    color: Colors.black,
  );
}

class MyAppBarTheme {
  // Private Constructor
  MyAppBarTheme._();

  /// Desktop
  static double DesktopIconSize = 2.5 * SizeConfig.widthMultiplier;
  static double DesktopTextSize = 2.0 * SizeConfig.widthMultiplier;
  static double DesktopPortraitHeight = 0.035 * SizeConfig.screenWidth;
  static double DesktopLandscapeHeight = 0.030 * SizeConfig.screenWidth;

  /// Tablet
  static double TabletIconSize = 3.5 * SizeConfig.widthMultiplier;
  static double TabletTextSize = 2.5 * SizeConfig.widthMultiplier;
  static double TabletPortraitHeight = 0.045 * SizeConfig.screenWidth;
  static double TabletLandscapeHeight = 0.050 * SizeConfig.screenWidth;

  /// Mobile
  static double MobileIconSize = 6.0 * SizeConfig.widthMultiplier;
  static double MobileTextSize = 4.5 * SizeConfig.widthMultiplier;
  static double MobilePortraitHeight = 0.120 * SizeConfig.screenWidth;
  static double MobileLandscapeHeight = 0.100 * SizeConfig.screenWidth;

  static Color BackgroundColor = Colors.white;
  static double Elevation = 2.0 * SizeConfig.widthMultiplier;
  static Color TextColor = const Color.fromARGB(255, 250, 250, 250);
  static Color IconColor = const Color.fromARGB(255, 250, 250, 250);

  static double IconPadding = 2.0 * SizeConfig.widthMultiplier;

  static double LeftPadding = 3.5 * SizeConfig.widthMultiplier;
  static double RightPadding = 3.5 * SizeConfig.widthMultiplier;

  static double BlurX = 15.0;
  static double BlurY = 15.0;
}
