import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Service/lesson_requests.dart';
import '../model/lesson_model.dart';

class LessonNotifier extends StateNotifier<AsyncValue<List<LessonModel>>> {
  LessonNotifier() : super(const AsyncLoading()) {
    initial();
  }
  final lessons = <LessonModel>[];
  int currentPage = 1;
  final int perPage = 10;
  bool hasMore = true;
  bool isFetching = false;

  Future<void> initial() async {
    lessons.clear();
    currentPage = 1;
    hasMore = true;
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
}

final lessonProvider =
    StateNotifierProvider<LessonNotifier, AsyncValue<List<LessonModel>>>(
  (ref) => LessonNotifier(),
);
