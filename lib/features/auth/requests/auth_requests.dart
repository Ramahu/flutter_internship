  import 'package:dio/dio.dart';

import '../../../app_configs.dart';
import '../../../core/network/remote/api_client.dart';
import '../model/user_model.dart';

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
      UserModel user = UserModel.fromJson(response.data);

      // print('========== STATUS CODE ==========');
      // print(response.statusCode);

      return {
        'success': true,
        'user' : user,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.statusMessage ?? 'Login failed',
      };
    }
  }

}