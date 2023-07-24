import 'package:dio/dio.dart';
import 'package:martin_pulgar_construction/src/config/config.dart';
import 'package:martin_pulgar_construction/src/features/diary/domain/model/diary_model.dart';

class DiaryRemoteSource {
  const DiaryRemoteSource({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  final Dio _httpClient;

  Future<bool> submitDiary(Diary diary) async {
    try {
      FormData formData = FormData();

      if (diary.files != null) {
        for (int i = 0; i < diary.files!.length; i++) {
          String fileName = 'image$i.jpg'; // Change the file name as needed
          formData.files.add(
            MapEntry(
              'image',
              await MultipartFile.fromFile(diary.files![i].path,
                  filename: fileName),
            ),
          );
        }
      }

      final response = await _httpClient.post(
        '${AppConfig.instance.restEndpoint}/api/diary',
        data: <String, dynamic>{
          'files': formData,
          'comment': diary.comment,
          'date': diary.date,
          'area': diary.area,
          'category': diary.category,
          'tags': diary.tags,
          'event': diary.event,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
