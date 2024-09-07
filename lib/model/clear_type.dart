enum ClearType {
  common,
  credentials,
  all;

  String get value {
    switch (this) {
      case ClearType.common:
        return "All General Data";
      case ClearType.credentials:
        return "All Credentials Data";
      case ClearType.all:
        return "All Data";
    }
  }
}
