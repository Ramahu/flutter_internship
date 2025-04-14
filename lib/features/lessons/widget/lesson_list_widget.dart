import 'package:flutter/material.dart';

import 'package:intern/features/lessons/provider/lesson_notifier.dart';
import 'package:intern/features/lessons/widget/state_widget.dart';

import '../model/lesson_model.dart';

Widget lessonsListWidget(
        ScrollController scrollController, List<LessonModel> lessons, ref) =>
    ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 8,
        );
      },
      itemBuilder: (context, index) {
        if (index < lessons.length) {
          final lesson = lessons[index];
          return lessonItem(lesson);
        } else {
          final lessonNotifier = ref.read(lessonProvider.notifier);
          final isLoadingMore = lessonNotifier.isFetching;
          final hasMore = lessonNotifier.hasMore;

          if (isLoadingMore) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: loadingWidget(),
            );
          } else if (!hasMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text('No more lessons.')),
            );
          } else {
            return const SizedBox.shrink();
          }
        }
      },
    );

Widget lessonItem(LessonModel lesson) => Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text(
              lesson.topic,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${lesson.subject.name}\n'
              'Start: ${lesson.startTime}\n'
              'End: ${lesson.endTime}',
            ),
            onTap: () {},
          ),
        ),
      ),
    );

