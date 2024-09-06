import 'package:rcache_flutter/rcache.dart';

class KeyModel {
  final String name;

  KeyModel({required this.name});

  RCacheKey get rCache {
    return RCacheKey(name);
  }

  @override
  bool operator ==(Object other) => other is KeyModel && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
