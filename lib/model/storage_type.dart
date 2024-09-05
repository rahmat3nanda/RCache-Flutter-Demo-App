import 'package:rcache_flutter/rcache.dart';
import 'package:rcache_flutter/rcaching.dart';

enum StorageType {
  common,
  credentials;

  String get value {
    switch (this) {
      case StorageType.common:
        return "General Data";
      case StorageType.credentials:
        return "Credentials Data";
    }
  }

  RCaching get rCache {
    switch (this) {
      case StorageType.common:
        return RCache.common;
      case StorageType.credentials:
        return RCache.credentials;
    }
  }
}
