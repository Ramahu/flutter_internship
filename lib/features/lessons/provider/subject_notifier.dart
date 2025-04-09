import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Service/subject_request.dart';
import '../model/subject_model.dart';

class SubjectNotifier extends StateNotifier<AsyncValue<List<SubjectModel>>> {
  SubjectNotifier() : super(const AsyncValue.loading()) {
    getSubjects();
  }

  List<SubjectModel> get subjects => state.value ?? [];

  Future<void> getSubjects() async {
    try {
      final subjects = await SubjectRequest().getSubjects();
      state = AsyncValue.data(subjects);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final subjectProvider =
    StateNotifierProvider<SubjectNotifier, AsyncValue<List<SubjectModel>>>(
  (ref) => SubjectNotifier(),
);
