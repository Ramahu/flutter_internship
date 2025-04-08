import 'package:flutter/material.dart';

import '../model/lesson_model.dart';

Widget lessonItem(LessonModel lesson) => Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
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
    );
