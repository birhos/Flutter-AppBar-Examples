import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

const double DesktopBreakpoint = 950;
const double TabletBreakpoint = 600;
const double WatchBreakpoint = 300;

class SizeConfig {
  static double screenWidth;
  static double screenHeight;

  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double widthMultiplier;
  static double heightMultiplier;

  static bool isPortrait = true;

  static bool isDesktopPortrait = false;
  static bool isTabletPortrait = false;
  static bool isMobilePortrait = false;
  static bool isWatchPortrait = false;

  static bool isDesktop = false;
  static bool isTablet = false;
  static bool isMobile = false;
  static bool isWatch = false;

  static double safeTop;
  static double safeBottom;
  static double safeLeft;
  static double safeRight;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      screenWidth = constraints.maxWidth;
      screenHeight = constraints.maxHeight;
      isPortrait = true;

      if (screenWidth <= WatchBreakpoint) {
        isWatch = true;
        isWatchPortrait = true;
      } else if (screenWidth > WatchBreakpoint &&
          screenWidth <= TabletBreakpoint) {
        isMobile = true;
        isMobilePortrait = true;
      } else if (screenWidth > TabletBreakpoint &&
          screenWidth <= DesktopBreakpoint) {
        isTablet = true;
        isTabletPortrait = true;
      } else {
        isDesktop = true;
        isDesktopPortrait = true;
      }
    } else {
      screenWidth = constraints.maxHeight;
      screenHeight = constraints.maxWidth;
      isPortrait = false;

      isDesktopPortrait = false;
      isTabletPortrait = false;
      isMobilePortrait = false;
      isWatchPortrait = false;

      if (screenWidth <= WatchBreakpoint) {
        isWatch = true;
      } else if (screenWidth > WatchBreakpoint &&
          screenWidth <= TabletBreakpoint) {
        isMobile = true;
      } else if (screenWidth > TabletBreakpoint &&
          screenWidth <= DesktopBreakpoint) {
        isTablet = true;
      } else {
        isDesktop = true;
      }
    }

    _blockWidth = screenWidth / 100;
    _blockHeight = screenHeight / 100;

    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

//    print("Screen Width :: $screenWidth");
//    print("Screen Height :: $screenHeight");
  }
}
