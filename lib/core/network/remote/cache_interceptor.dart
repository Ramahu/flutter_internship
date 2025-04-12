import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor {
  CacheInterceptor() {
    dioCacheInterceptor = DioCacheInterceptor(options: options);
  }
  late DioCacheInterceptor dioCacheInterceptor;

  final CacheOptions options = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    hitCacheOnErrorCodes: [401, 403],
    priority: CachePriority.high,
    maxStale: const Duration(days: 7),
  );
}
