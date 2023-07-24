import 'package:martin_pulgar_construction/src/features/diary/data/remote/remote.dart';
import 'package:martin_pulgar_construction/src/services/services.dart';

final diaryRemoteSourceDI = DiaryRemoteSource(httpClient: dioClient);