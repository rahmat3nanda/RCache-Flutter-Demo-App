import 'package:rcache_flutter/rcache.dart';

class AppRCacheKey {
  static RCacheKey get savedKeys => RCacheKey("savedKeys");

  static RCacheKey get logs => RCacheKey("logs");
}
