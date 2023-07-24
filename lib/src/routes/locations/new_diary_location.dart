import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:martin_pulgar_construction/src/features/diary/presentation/screens/new_diary_screen.dart';

class NewDiaryLocation extends BeamLocation<BeamState> {
  static const route = '/new-diary';

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      const BeamPage(
        key: ValueKey('new-diary'),
        name: 'New Diary Screen',
        title: 'New Diary',
        child: NewDiaryScreen(),
      )
    ];
  }

  @override
  List<Pattern> get pathPatterns => const [route];
}
