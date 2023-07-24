
import 'package:martin_pulgar_construction/src/features/diary/data/repository/repository.dart';
import 'package:martin_pulgar_construction/src/features/diary/dependency_injection/diary_remote_source_di.dart';

final diaryRepositoryDI =
    DiaryRepositoryImpl(remoteSource: diaryRemoteSourceDI);