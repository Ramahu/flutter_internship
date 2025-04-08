import 'package:dio/dio.dart';

import '../../../app_configs.dart';
import '../../../core/network/remote/api_client.dart';
import '../model/lesson_model.dart';

class LessonRequests {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> getLessons(
      {required int page, int perPage = 10}) async {
    try {
      Response response = await apiClient.getRequest(
        endpoint: '${AppConfigs.lesson}?page=$page&per_page=$perPage',
      );
      final data = response.data;

      final lessons = (data['data'] as List)
          .map((item) => LessonModel.fromJson(item))
          .toList();

      final meta = MetaModel.fromJson(data['meta']);

      return {
        'success': true,
        'lessons': lessons,
        'meta': meta,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'],
      };
    }
  }
}
