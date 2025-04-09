import '../../../app_configs.dart';
import '../../../core/network/remote/api_client.dart';
import '../model/subject_model.dart';

class SubjectRequest {
  final ApiClient apiClient = ApiClient();

  Future<List<SubjectModel>> getSubjects() async {
    try {
      final response = await apiClient.getRequest(
        endpoint: AppConfigs.subject,
      );

      final subjects = (response.data['subjects'] as List)
          .map((item) => SubjectModel.fromJson(item))
          .toList();

      return subjects;
    } catch (_) {
      return [];
    }
  }
}
