import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class CacheInterceptor {
  static late final DioCacheInterceptor dioCacheInterceptor;
  static late final CacheOptions cacheOptions;

  static Future<void> init() async {
    cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache,
      priority: CachePriority.high,
      maxStale: const Duration(days: 7),
      hitCacheOnErrorCodes: [401, 403],
      allowPostMethod: false,
      hitCacheOnNetworkFailure: true,
      keyBuilder: ({headers, required url}) => 'subjects',
    );

    dioCacheInterceptor = DioCacheInterceptor(options: cacheOptions);
  }
  static final CacheOptions noCacheOptions = CacheOptions(
    policy: CachePolicy.noCache,
    store: MemCacheStore(),
  );

}

class RemoveCacheControlInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.headers.removeAll('cache-control');
    return handler.next(response);
  }
}
