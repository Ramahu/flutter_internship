import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Service/lesson_requests.dart';
import '../model/lesson_model.dart';

class LessonNotifier extends StateNotifier<AsyncValue<List<LessonModel>>> {
  LessonNotifier() : super(const AsyncLoading());

  final lessons = <LessonModel>[];
  final filterdLessons = <LessonModel>[];

  int currentPage = 1;
  final int perPage = 10;
  bool hasMore = true;
  bool isFetching = false;
  String? currentQuery;

  Future<void> initial() async {
    lessons.clear();
    currentPage = 1;
    hasMore = true;
    currentQuery = null;
    await getLessons();
  }

  Future<void> next() async {
    if (hasMore && !isFetching) {
      currentPage++;
      await getLessons();
    }
  }

  Future<void> getLessons() async {
    isFetching = true;
    try {
      if (lessons.isEmpty) {
        state = const AsyncLoading();
      }
      final lessonRequests = LessonRequests();
      var response = await lessonRequests.getLessons(
        page: currentPage,
        perPage: perPage,
        query: currentQuery,
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

  Future<void> search(String query) async {
    lessons.clear();
    currentQuery = query;
    currentPage = 1;
    hasMore = true;
    await getLessons();
  }

  Future<void> getFilterdLesson(subjectId, query,
      {bool clearOld = false}) async {
    isFetching = true;
    try {
      if (clearOld) {
        filterdLessons.clear();
        currentPage = 1;
        hasMore = true;
      }
      if (filterdLessons.isEmpty) {
        state = const AsyncLoading();
      }
      final lessonRequests = LessonRequests();
      var response = await lessonRequests.getFilterdLesson(
        page: currentPage,
        perPage: perPage,
        subjectId: subjectId,
        query: query,
      );
      if (response['success']) {
        final List<LessonModel> newLessons =
            response['lessons'] as List<LessonModel>;
        final meta = response['meta'];

        filterdLessons.addAll(newLessons);
        hasMore = meta.hasMore;

        state = AsyncValue.data([...filterdLessons]);
      } else {
        state = AsyncValue.error(response['message'], StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      isFetching = false;
    }
  }

  Future<void> nextFilter(subjectId, query) async {
    if (hasMore && !isFetching) {
      currentPage++;
      await getFilterdLesson(subjectId, query);
    }
  }
}

final lessonProvider =
    StateNotifierProvider<LessonNotifier, AsyncValue<List<LessonModel>>>(
  (ref) => LessonNotifier(),
);
