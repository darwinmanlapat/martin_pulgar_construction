import 'package:beamer/beamer.dart';
import 'package:martin_pulgar_construction/src/routes/locations/locations.dart';

final locationBuilder = BeamerLocationBuilder(
  beamLocations: [
    DiaryLocation(),
    NewDiaryLocation(),
  ],
);
