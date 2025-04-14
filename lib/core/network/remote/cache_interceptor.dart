import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor {
  static final CacheOptions cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.forceCache,
    priority: CachePriority.high,
    maxStale: const Duration(days: 7),
    hitCacheOnErrorCodes: [401, 403],
    allowPostMethod: false,
    hitCacheOnNetworkFailure: true,
  );

  static final CacheOptions noCacheOptions = CacheOptions(
    policy: CachePolicy.noCache,
    store: MemCacheStore(),
  );

  static final DioCacheInterceptor dioCacheInterceptor =
      DioCacheInterceptor(options: cacheOptions);
}

class RemoveCacheControlInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.headers.removeAll('cache-control');
    return handler.next(response);
  }
}
