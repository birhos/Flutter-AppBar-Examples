import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:appbar_examples/others/styling.dart';
import 'package:appbar_examples/others/sizeConfig.dart';

class HomePageFloatingAppBar extends StatefulWidget {
  @override
  _HomePageFloatingAppBarState createState() => _HomePageFloatingAppBarState();
}

class _HomePageFloatingAppBarState extends State<HomePageFloatingAppBar>
    with TickerProviderStateMixin {
  FloatingHeaderSnapConfiguration _snapConfiguration;

  void _updateSnapConfiguration() {
    _snapConfiguration = FloatingHeaderSnapConfiguration(
      vsync: this,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void initState() {
    super.initState();

    _updateSnapConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: SliverPersistentHeader(
        floating: true,
        pinned: false,
        delegate: _SliverAppBarDelegate(
          snapConfiguration: _snapConfiguration,
        ),
      ),
    );
  }
}

class _FloatingAppBar extends StatefulWidget {
  final Widget child;

  const _FloatingAppBar({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  _FloatingAppBarState createState() => _FloatingAppBarState();
}

class _FloatingAppBarState extends State<_FloatingAppBar> {
  ScrollPosition _position;

  RenderSliverFloatingPersistentHeader _headerRenderer() {
    return context.ancestorRenderObjectOfType(
        const TypeMatcher<RenderSliverFloatingPersistentHeader>());
  }

  void _isScrollingListener() {
    if (_position == null) return;

    final RenderSliverFloatingPersistentHeader header = _headerRenderer();
    if (_position.isScrollingNotifier.value) {
      header?.maybeStopSnapAnimation(_position.userScrollDirection);
    } else {
      header?.maybeStartSnapAnimation(_position.userScrollDirection);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_position != null) {
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    }

    _position = Scrollable.of(context)?.position;
    if (_position != null) {
      _position.isScrollingNotifier.addListener(_isScrollingListener);
    }
  }

  @override
  void dispose() {
    if (_position != null) {
      _position.isScrollingNotifier.removeListener(_isScrollingListener);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.snapConfiguration,
  });

  @override
  double get maxExtent =>
      MyAppBarTheme.MobilePortraitHeight + SizeConfig.safeTop;

  @override
  double get minExtent => 0;

  @override
  final FloatingHeaderSnapConfiguration snapConfiguration;

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return snapConfiguration != oldDelegate.snapConfiguration;
  }

  @override
  String toString() {
    return '';
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double visibleMainHeight = maxExtent - shrinkOffset;
    final double toolbarOpacity = ((visibleMainHeight) /
            (MyAppBarTheme.MobilePortraitHeight + SizeConfig.safeTop))
        .clamp(0.0, 1.0);

    final Widget appBar = FlexibleSpaceBar.createSettings(
      minExtent: minExtent,
      maxExtent: maxExtent,
      toolbarOpacity: toolbarOpacity,
      currentExtent: math.max(minExtent, maxExtent - shrinkOffset),
      child: PreferredSize(
        preferredSize: Size.fromHeight(
            MyAppBarTheme.MobilePortraitHeight + SizeConfig.safeTop),
        child: Container(
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
                  /// Başlık

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Home Page",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.display1.copyWith(
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
    );

    return _FloatingAppBar(
      child: appBar,
    );
  }
}
