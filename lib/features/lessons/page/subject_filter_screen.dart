import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/features/lessons/widget/lesson_list_widget.dart';

import '../model/subject_model.dart';
import '../provider/lesson_notifier.dart';
import '../provider/subject_notifier.dart';
import '../widget/state_widget.dart';

class SubjectFilterScreen extends ConsumerStatefulWidget {
  const SubjectFilterScreen({super.key});

  @override
  ConsumerState<SubjectFilterScreen> createState() =>
      SubjectFilterScreenState();
}

class SubjectFilterScreenState extends ConsumerState<SubjectFilterScreen> {
  final ScrollController _scrollController = ScrollController();
  SubjectModel? selectedSubject;

  @override
  void initState() {
    super.initState();
    getSubjects();
  }

  Future<void> getSubjects() async {
    final lessonNotifier = ref.read(lessonProvider.notifier);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !lessonNotifier.isFetching &&
          lessonNotifier.hasMore) {
        lessonNotifier.nextFilter(selectedSubject?.id, '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(lessonProvider);
    final subjectState = ref.watch(subjectProvider);
    final subjects = subjectState.value ?? [];
    final isLoading = subjectState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: DropdownButtonFormField<SubjectModel>(
              value: selectedSubject,
              hint: const Text('Select Subject'),
              items: subjects.map((subject) {
                return DropdownMenuItem<SubjectModel>(
                  value: subject,
                  child: Text(subject.name),
                );
              }).toList(),
              onChanged: isLoading
                  ? null
                  : (subject) {
                      setState(() {
                        selectedSubject = subject;
                      });
                      ref.read(lessonProvider.notifier).getFilterdLesson(
                            subject?.id,
                            '',
                            clearOld: true,
                          );
                    },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: selectedSubject == null
                  ? const Center(child: Text('Please select a subject.'))
                  : lessonState.when(
                      loading: loadingWidget,
                      error: (e, _) => errorWidget(e),
                      data: (filterdLessons) {
                        if (filterdLessons.isEmpty) {
                          return const Center(
                              child: Text('No lessons available.'));
                        }
                        return lessonsListWidget(
                            _scrollController, filterdLessons, ref);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
