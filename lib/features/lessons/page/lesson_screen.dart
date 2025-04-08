import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/icons.dart';
import '../model/lesson_model.dart';
import '../provider/lesson_notifier.dart';
import '../widget/lesson_item_widget.dart';
import '../widget/state_widget.dart';

class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key});

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(lessonProvider.notifier).getLessons();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !ref.read(lessonProvider.notifier).isFetching &&
          ref.read(lessonProvider.notifier).hasMore) {
        ref.read(lessonProvider.notifier).next();
      }
    });

    searchController.addListener(() {
      if (debounce?.isActive ?? false) debounce!.cancel();
      debounce = Timer(const Duration(milliseconds: 500), () {
        final query = searchController.text.trim();
        ref.read(lessonProvider.notifier).search(query);
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('online lessons'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search lessons',
                border: const OutlineInputBorder(),
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
          final isLoadingMore = ref.read(lessonProvider.notifier).isFetching;
          final hasMore = ref.read(lessonProvider.notifier).hasMore;

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
