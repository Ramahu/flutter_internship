import 'package:dio/dio.dart';

import '../../../core/client/api_client.dart';
import '../../../configs/app_configs.dart';
import '../../lessons/model/lesson_model.dart';
import '../model/accessory_model.dart';

class AccessoryRequests {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> getAccessories({
    required int page,
    int perPage = 10,
    String? query,
    String? contentType,
  }) async {
    try {
      final base = '${AppConfigs.accessory}?page=$page&per_page=$perPage';
      late final String endpoint;

      if (contentType == null && (query == null || query.isEmpty)) {
        endpoint = base;
      } else if (query != null && contentType == null) {
        endpoint = '$base&query=$query';
      } else {
        final queryParam = '&query=${query ?? ''}';
        endpoint = '$base$queryParam&content_type=$contentType';
      }

      
      final response = await apiClient.getRequest(
        endpoint: endpoint,
      );
      final data = response.data;

      List<AccessoryModel> accessories = (data['data'] as List)
          .map((item) => AccessoryModel.fromJson(item))
          .toList();
          
      final meta = MetaModel.fromJson(data['meta']);    

      return {
        'success': true,
        'accessories': accessories,
        'meta': meta,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Something went wrong',
      };
    }
  }
}
