import 'package:martin_pulgar_construction/src/features/diary/data/remote/remote.dart';
import 'package:martin_pulgar_construction/src/features/diary/domain/model/diary_model.dart';
import 'package:martin_pulgar_construction/src/features/diary/domain/repository/repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  const DiaryRepositoryImpl({
    required DiaryRemoteSource remoteSource,
  }) : _remoteSource = remoteSource;

  final DiaryRemoteSource _remoteSource;

  @override
  Future<bool> submitDiary(Diary diary) async {
    final remote = await _remoteSource.submitDiary(diary);
    return remote;
  }
}
