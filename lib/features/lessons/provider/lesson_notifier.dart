import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Service/lesson_requests.dart';
import '../model/lesson_model.dart';
import '../model/subject_model.dart';

class LessonNotifier extends StateNotifier<AsyncValue<List<LessonModel>>> {
  LessonNotifier() : super(const AsyncLoading());

  final lessons = <LessonModel>[];
  final filterdLessons = <LessonModel>[];
  final subjects = <SubjectModel>[];

  int currentPage = 1;
  int perPage = 10;
  bool hasMore = true;
  bool isFetching = false;
  String? currentQuery;
  int? subjectId;

  Future<void> initial() async {
    currentQuery = null;
    subjectId = null;
    await Future.wait([
      getSubjects(),
      getLessons(clear: true),
    ]);
  }

  Future<void> getLessons({bool clear = false}) async {
    isFetching = true;
    try {
      if (clear) {
        lessons.clear();
        currentPage = 1;
        hasMore = true;
      }
      if (lessons.isEmpty) {
        state = const AsyncLoading();
      }
      final lessonRequests = LessonRequests();
      var response = await lessonRequests.getLessons(
        page: currentPage,
        perPage: perPage,
        query: currentQuery,
        subjectId: subjectId,
      );
      if (response['success']) {
        final List<LessonModel> newLessons =
            response['lessons'] as List<LessonModel>;
        final meta = response['meta'];

        lessons.addAll(newLessons);
        hasMore = meta.hasMore;

        state = AsyncValue.data([...lessons]);
      } else {
        state = AsyncValue.error(response['message'], StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      isFetching = false;
    }
  }

  Future<void> next() async {
    if (hasMore && !isFetching) {
      currentPage++;
      await getLessons();
    }
  }

  void setSearchQuery(String? query) {
    currentQuery = query;
    getLessons(clear: true);
  }

  void setSubjectFilter(int? selectedSubjectId) {
    subjectId = selectedSubjectId;
    getLessons(clear: true);
  }

  Future<void> getSubjects() async {
    try {
      final result = await LessonRequests().getSubjects();
      subjects
        ..clear()
        ..addAll(result);
    } catch (e) {
      //
    }
  }
}

final lessonProvider =
    StateNotifierProvider<LessonNotifier, AsyncValue<List<LessonModel>>>(
  (ref) => LessonNotifier(),
);
