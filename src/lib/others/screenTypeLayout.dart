import 'package:flutter/material.dart';

import 'sizeConfig.dart';

class ScreenTypeLayout extends StatelessWidget {
  final WidgetBuilder watch;
  final WidgetBuilder mobile;
  final WidgetBuilder tablet;
  final WidgetBuilder desktop;

  ScreenTypeLayout(
      {Key key, Widget watch, Widget mobile, Widget tablet, Widget desktop})
      : this.watch = _builderOrNull(watch),
        this.mobile = _builderOrNull(mobile),
        this.tablet = _builderOrNull(tablet),
        this.desktop = _builderOrNull(desktop),
        super(key: key);

  static WidgetBuilder _builderOrNull(Widget widget) {
    return widget == null ? null : ((_) => widget);
  }

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.isDesktop == true) {
      if (desktop != null) return desktop(context);
      if (tablet != null) return tablet(context);
    } else if (SizeConfig.isTablet == true) {
      if (tablet != null) return tablet(context);
    } else if (SizeConfig.isMobile == true) {
      if (mobile != null) return mobile(context);
    } else if (SizeConfig.isWatch == true) {
      if (watch != null) return watch(context);
    }

    return Container();
  }
}

class OrientationLayoutBuilder extends StatelessWidget {
  final WidgetBuilder landscape;
  final WidgetBuilder portrait;

  const OrientationLayoutBuilder({
    Key key,
    this.landscape,
    this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.isPortrait) {
      return portrait(context);
    }

    return landscape(context);
  }
}
