enum StorageType {
  common,
  credentials,
  all;

  String get value {
    switch (this) {
      case StorageType.common:
        return "All General Data";
      case StorageType.credentials:
        return "All Credentials Data";
      case StorageType.all:
        return "All Data";
    }
  }
}
