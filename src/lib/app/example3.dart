import 'dart:ui';
import 'dart:async';

import 'package:appbar_examples/others/styling.dart';
import 'package:flutter/material.dart';

import 'package:appbar_examples/others/sizeConfig.dart';

// https://stackoverflow.com/questions/51321804/how-to-fade-in-out-a-widget-from-sliverappbar-while-scrolling

class Example3 extends StatefulWidget {
  @override
  _Example3State createState() => _Example3State();
}

class _Example3State extends State<Example3> {
  bool allowBlocStateUpdates = false;

  void allowBlocUpdates(bool allow) =>
      setState(() => allowBlocStateUpdates = allow);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (details) => allowBlocUpdates(true),
        onPointerUp: (details) => allowBlocUpdates(true),

        /// false
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              FlexibleHeader(
                allowBlocStateUpdates: allowBlocStateUpdates,
                innerBoxIsScrolled: innerBoxIsScrolled,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ),
            ];
          },

          // ************************** ************************** ************************** **************************

          body: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            color: const Color.fromARGB(255, 46, 46, 46),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MyAppBarTheme.MobilePortraitHeight +
                        12.50 * SizeConfig.widthMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 2.0 * SizeConfig.widthMultiplier,
                      right: 2.0 * SizeConfig.widthMultiplier,
                    ),
                    child: Text(
                      '''The Walking Dead is an American post-apocalyptic horror television series for AMC based on the comic book series by Robert Kirkman, Tony Moore, and Charlie Adlard. The series features a large ensemble cast as survivors of a zombie apocalypse, trying to stay alive under near-constant threat of attacks from the mindless zombies, colloquially known as "walkers". However, with the fall of humanity, these survivors also face conflict from other living survivors who have formed groups and communities with their own sets of laws and morals, often leading to hostile conflict between the human communities. Andrew Lincoln played the series's lead character, Rick Grimes, until his departure during the ninth season. Other long-standing cast members have included Norman Reedus, Steven Yeun, Chandler Riggs, Melissa McBride, Lauren Cohan, Danai Gurira, Josh McDermitt and Christian Serratos.

The series is exclusively broadcast on AMC in the United States and internationally through the Fox Networks Group. The series premiered on October 31, 2010. The tenth season premiered on October 6, 2019, and has been renewed for an eleventh season. AMC stated their intent to continue further development of the series and related media. A spinoff series Fear the Walking Dead premiered on August 23, 2015, and is renewed for a sixth season. A second spinoff, The Walking Dead: World Beyond, is set to premiere in early 2020. AMC has announced plans for three films to follow Rick's story after Lincoln's departure.

The Walking Dead is produced by AMC Studios within the state of Georgia, with most filming taking place in the large outdoor spaces of Riverwood Studios near Senoia, Georgia. The series was adapted from the comic by Frank Darabont, who also served as the showrunner for the first season. However, conflicts between Darabont and AMC forced his departure from the series, and which is currently subject to multiple lawsuits by Darabont and others. Following Darabont, Glen Mazzara, Scott M. Gimple, and Angela Kang have all served as showrunners.

Beginning with its third season, The Walking Dead has attracted the most 18- to 49-year-old viewers of any cable or broadcast television series, though viewership has declined in later seasons. The series has been well received by critics, although reception has declined as the series has progressed.[3] It has been nominated for several awards, including the Writers Guild of America Award for New Series and the Golden Globe Award for Best Television Series – Drama.[4][5]''',
                      style: Theme.of(context).textTheme.display1.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 3.5 * SizeConfig.widthMultiplier,
                            fontWeight: FontWeight.w100,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ************************** ************************** ************************** **************************
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  const _SliverAppBarDelegate({
    this.child,
  });

  @override
  double get minExtent => 0;

  @override
  double get maxExtent => 0.10 * SizeConfig.widthMultiplier;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

class FlexibleHeader extends StatefulWidget {
  final bool allowBlocStateUpdates;
  final bool innerBoxIsScrolled;

  const FlexibleHeader({
    Key key,
    this.allowBlocStateUpdates,
    this.innerBoxIsScrolled,
  }) : super(key: key);

  @override
  _FlexibleHeaderState createState() => _FlexibleHeaderState();
}

class _FlexibleHeaderState extends State<FlexibleHeader> {
  FlexibleHeaderBloc bloc;

  @override
  void initState() {
    bloc = FlexibleHeaderBloc();

    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: bloc.initial(),
      stream: bloc.stream,
      builder:
          (BuildContext context, AsyncSnapshot<FlexibleHeaderState> stream) {
        FlexibleHeaderState state = stream.data;

        return SliverOverlapAbsorber(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          sliver: SliverAppBar(
            pinned: true,
            primary: true,
            forceElevated: widget.innerBoxIsScrolled,
            expandedHeight: SizeConfig.screenHeight * 0.50,
            backgroundColor: const Color.fromARGB(255, 34, 34, 34),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  right: 5.0 * SizeConfig.widthMultiplier,
                ),
                child: Icon(
                  Icons.menu,
                  size: 5.0 * SizeConfig.widthMultiplier,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
            leading: Opacity(
              opacity: state.opacityAppBar,
              child: Icon(
                Icons.arrow_back,
              ),
            ),
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (widget.allowBlocStateUpdates) {
                  bloc.update(state, constraints.maxHeight);
                }

                return Opacity(
                  opacity: state.opacityFlexible < 0.05
                      ? 0.0
                      : state.opacityFlexible,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://images7.alphacoders.com/565/565053.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: state.opacityAppBar * 2.5,
                            sigmaY: state.opacityAppBar * 2.5,
                          ),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: Colors.black.withOpacity(0.50),
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(
                            left: 2.5 * SizeConfig.widthMultiplier,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Opacity(
                                opacity: state.opacityFlexible < 0.05
                                    ? 0.0
                                    : state.opacityFlexible,
                                child: Container(
                                  width: 13.0 * SizeConfig.widthMultiplier,
                                  height: 13.0 * SizeConfig.widthMultiplier,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://www.horrornewsnetwork.net/wp-content/uploads/2017/12/walking-dead-featured.jpg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.ac_unit,
                                    size: 6.0 * SizeConfig.widthMultiplier,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                  SizedBox(
                                    width: 2.0 * SizeConfig.widthMultiplier,
                                  ),
                                  Text(
                                    "The Walking Dead (ES)",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize:
                                              4.5 * SizeConfig.widthMultiplier,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.5 * SizeConfig.widthMultiplier,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "October 31, 2010",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                          color: const Color.fromARGB(
                                              255, 205, 205, 205),
                                          fontSize:
                                              2.75 * SizeConfig.widthMultiplier,
                                        ),
                                  ),
                                  Container(
                                    width: 2.5 * SizeConfig.widthMultiplier,
                                    height: 0.50 * SizeConfig.widthMultiplier,
                                    color: const Color.fromARGB(
                                        255, 205, 205, 205),
                                    margin: EdgeInsets.only(
                                      left: 2.0 * SizeConfig.widthMultiplier,
                                      right: 2.0 * SizeConfig.widthMultiplier,
                                    ),
                                  ),
                                  Text(
                                    "October 6, 2019",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(
                                          color: const Color.fromARGB(
                                              255, 205, 205, 205),
                                          fontSize:
                                              2.75 * SizeConfig.widthMultiplier,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.5 * SizeConfig.widthMultiplier,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

/// The variables necessary for proper functionality in the FlexibleHeader
class FlexibleHeaderState {
  double initialHeight;
  double currentHeight;

  double opacityFlexible = 1;
  double opacityAppBar = 0;

  FlexibleHeaderState();
}

class FlexibleHeaderBloc {
  StreamController<FlexibleHeaderState> controller =
      StreamController<FlexibleHeaderState>();

  Stream<FlexibleHeaderState> get stream => controller.stream;

  Sink get sink => controller.sink;

  void _update(FlexibleHeaderState state) => sink.add(state);

  FlexibleHeaderBloc();

  FlexibleHeaderState initial() => FlexibleHeaderState();

  void _updateOpacity(FlexibleHeaderState state) {
    if (state.initialHeight == null || state.currentHeight == null) {
      state.opacityFlexible = 1;
      state.opacityAppBar = 0;
    } else {
      final double offset = (1 / 3) * state.initialHeight;
      double opacity =
          (state.currentHeight - offset) / (state.initialHeight - offset);

      opacity <= 1 ? opacity = opacity : opacity = 1;
      opacity >= 0 ? opacity = opacity : opacity = 0;

      state.opacityFlexible = opacity;
      state.opacityAppBar = (1 - opacity).abs();
    }
  }

  void update(FlexibleHeaderState state, double currentHeight) {
    state.initialHeight ??= currentHeight;
    state.currentHeight = currentHeight;

    _updateOpacity(state);
    _update(state);
  }

  void dispose() {
    controller.close();
  }
}
