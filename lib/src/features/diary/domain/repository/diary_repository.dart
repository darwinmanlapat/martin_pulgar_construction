import 'package:martin_pulgar_construction/src/features/diary/domain/model/model.dart';

abstract class DiaryRepository {
  Future<bool> submitDiary(Diary diary);
}
