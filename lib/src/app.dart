import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:martin_pulgar_construction/src/routes/location_builder.dart';

class MartinPulgarConstruction extends HookWidget {
  const MartinPulgarConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    final routerDelegate = useMemoized(() {
      return BeamerDelegate(
        initialPath: '/new-diary',
        locationBuilder: locationBuilder,
        transitionDelegate: const NoAnimationTransitionDelegate(),
        beamBackTransitionDelegate: const NoAnimationTransitionDelegate(),
      );
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}
