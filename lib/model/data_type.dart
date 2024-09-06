import 'dart:core';

enum DataType {
  uint8List,
  string,
  boolean,
  integer,
  array,
  map,
  double;

  String get value {
    switch (this) {
      case DataType.uint8List:
        return "Uint8List";
      case DataType.string:
        return "String";
      case DataType.boolean:
        return "Boolean";
      case DataType.integer:
        return "Integer";
      case DataType.array:
        return "Array";
      case DataType.map:
        return "Map";
      case DataType.double:
        return "Double";
    }
  }

  bool get isNumber {
    switch (this) {
      case DataType.integer:
      case DataType.double:
        return true;
      default:
        return false;
    }
  }

  bool get isUseTextField {
    switch (this) {
      case DataType.boolean:
      case DataType.array:
      case DataType.map:
        return false;
      default:
        return true;
    }
  }
}
