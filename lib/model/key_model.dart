import 'package:rcache_flutter/rcache.dart';

class KeyModel {
  final String name;

  KeyModel({required this.name});

  RCacheKey get rCache {
    return RCacheKey(name);
  }
}
