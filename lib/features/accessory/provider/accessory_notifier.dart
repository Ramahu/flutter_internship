import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/accessory_model.dart';
import '../service/accessory_requests.dart';

class AccessoryNotifier
    extends StateNotifier<AsyncValue<List<AccessoryModel>>> {
  AccessoryNotifier() : super(const AsyncLoading());

  final accessories = <AccessoryModel>[];
  final List<String> contentTypes = ['files', 'urls', 'videos', 'images'];

  int currentPage = 1;
  int perPage = 10;
  bool hasMore = true;
  bool isFetching = false;
  String? currentQuery;
  String? contentType;

  Future<void> initial() async {
    currentQuery = null;
    contentType = null;
    await getAccessories(clear: true);
  }

  Future<void> getAccessories({bool clear = false}) async {
    isFetching = true;
    try {
      if (clear) {
        accessories.clear();
        currentPage = 1;
        hasMore = true;
      }
      if (accessories.isEmpty) {
        state = const AsyncLoading();
      }
      final accessoriesRequests = AccessoryRequests();
      var response = await accessoriesRequests.getAccessories(
        page: currentPage,
        perPage: perPage,
        query: currentQuery,
        contentType: contentType,
      );
      if (response['success']) {
        final List<AccessoryModel> newAccessories =
            response['accessories'];
        final meta = response['meta'];

        accessories.addAll(newAccessories);
        hasMore = meta.hasMore;

        state = AsyncValue.data([...accessories]);
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
      await getAccessories();
    }
  }

  void setSearchQuery(String? query) {
    currentQuery = query;
    getAccessories(clear: true);
  }

  void setTypeFilter(String? selectedContentType) {
    contentType = selectedContentType;
    getAccessories(clear: true);
  }
}

final accessoryProvider =
    StateNotifierProvider<AccessoryNotifier, AsyncValue<List<AccessoryModel>>>(
  (ref) => AccessoryNotifier(),
);
