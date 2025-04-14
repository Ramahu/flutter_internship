import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../app_configs.dart';
import '../../../core/network/remote/api_client.dart';
import '../../../core/network/remote/cache_interceptor.dart';
import '../model/lesson_model.dart';
import '../model/subject_model.dart';

class LessonRequests {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> getLessons({
    required int page,
    int perPage = 10,
    String? query,
    int? subjectId,
  }) async {
    try {
      final base = '${AppConfigs.lesson}?page=$page&per_page=$perPage';
      late final String endpoint;

      if (subjectId == null && (query == null || query.isEmpty)) {
        endpoint = base;
      } else if (query != null && subjectId == null) {
        endpoint = '$base&query=$query';
      } else {
        final queryParam = '&query=${query ?? ''}';
        endpoint = '$base&subject_id=$subjectId$queryParam';
      }

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
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final cachedResponse =
          await CacheInterceptor.cacheOptions.store!.get('subjects');

      if (cachedResponse != null) {
        log('Returning cached response');
        final decodedResponse = utf8.decode(cachedResponse.content ?? []);
        final decodedJson = jsonDecode(decodedResponse);

        log('Cached data: $decodedJson');

        final subjects = (decodedJson['subjects'] as List)
            .map((item) => SubjectModel.fromJson(item))
            .toList();
        return subjects;
      } else {
        log('No cached data found');
        final response = await apiClient.getRequest(
          endpoint: AppConfigs.subject,
          isCached: true,
        );
        final subjects = (response.data['subjects'] as List)
            .map((item) => SubjectModel.fromJson(item))
            .toList();
        return subjects;
      }
    } catch (e) {
      return [];
    }
  }
}
