import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:martin_pulgar_construction/src/features/diary/presentation/screens/screens.dart';

class DiaryLocation extends BeamLocation<BeamState> {
  static const route = '/diary';

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('diary'),
        name: 'Diary Screen',
        title: 'Diary',
        child: DiaryScreen(),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => const [route];
}
