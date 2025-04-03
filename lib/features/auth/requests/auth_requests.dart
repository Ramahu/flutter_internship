  import 'package:dio/dio.dart';

import '../../../app_configs.dart';
import '../../../core/network/remote/api_client.dart';

class AuthRequests {
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      var data = FormData.fromMap({
        'email_or_serial_number': email,
        'password': password,
      });

      Response response = await apiClient.postRequest(
        endpoint: AppConfigs.login,
        data: data,
      );

      // print('============ RESPONSE ===========');
      // print(response.data);
      // print('========== STATUS CODE ==========');
      // print(response.statusCode);

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      // print('=========== ERROR ============');
      // print(e.response?.data ?? e.message);

      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Login failed',
      };
    }
  }

}