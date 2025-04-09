import 'package:dio/dio.dart';

import '../../../app_configs.dart';
import '../../../core/network/remote/api_client.dart';
import '../model/lesson_model.dart';

class LessonRequests {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> getLessons({
    required int page,
    int perPage = 10,
    String? query,
  }) async {
    try {
      final queryString =
          query != null && query.isNotEmpty ? '&query=$query' : '';

      final String endpoint =
          '${AppConfigs.lesson}?page=$page&per_page=$perPage$queryString';

      Response response = await apiClient.getRequest(endpoint: endpoint);
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

  Future<Map<String, dynamic>> getFilterdLesson({
    required int page,
    int perPage = 10,
    required String query,
    required int subjectId,
  }) async {
    try {
      final queryString =
          'page=$page&per_page=$perPage&subject_id=$subjectId&query=$query';

      final response = await apiClient.getRequest(
          endpoint: '${AppConfigs.lesson}?$queryString');
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
