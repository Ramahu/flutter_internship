import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intern/features/lessons/widget/lesson_list_widget.dart';

import '../../../core/util/icons.dart';
import '../model/subject_model.dart';
import '../provider/lesson_notifier.dart';
import '../widget/state_widget.dart';

class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key});

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  SubjectModel? selectedSubject;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    final lessonNotifier = ref.read(lessonProvider.notifier);

    Future.microtask(() async {
      await lessonNotifier.initial();
      final allSubject = SubjectModel(id: null, name: 'All');
      if (!lessonNotifier.subjects.any((s) => s.id == null)) {
        lessonNotifier.subjects.insert(0, allSubject);
      }
      setState(() {
        selectedSubject = allSubject;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !lessonNotifier.isFetching &&
          lessonNotifier.hasMore) {
        lessonNotifier.next();
      }
    });

    searchController.addListener(() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 500), () {
        final query = searchController.text.trim();
        lessonNotifier.setSearchQuery(query);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lessonState = ref.watch(lessonProvider);
    final lessonNotifier = ref.read(lessonProvider.notifier);

    return Scaffold(
      // subject drop down
      appBar: AppBar(
        title: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Online Lessons',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButtonFormField<SubjectModel>(
                      value: selectedSubject,
                      hint: const Text('Select Subject'),
                      items: lessonNotifier.subjects.map((subject) {
                        return DropdownMenuItem<SubjectModel>(
                          value: subject,
                          child: Text(subject.name),
                        );
                      }).toList(),
                      onChanged: (subject) {
                        setState(() => selectedSubject = subject);
                        lessonNotifier.setSubjectFilter(subject?.id);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          // search text field
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search lessons',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: const Icon(search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: searchController.clear,
                      )
                    : null,
              ),
            ),
          ),
          // lesson list
          Expanded(
            child: lessonState.when(
              loading: loadingWidget,
              error: (e, _) => errorWidget(e),
              data: (lessons) {
                if (lessons.isEmpty) {
                  return const Center(child: Text('No lessons available.'));
                }
                return lessonsListWidget(_scrollController, lessons, ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}
