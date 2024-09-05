import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:rcache_demo_flutter/app_rcache_key.dart';
import 'package:rcache_flutter/rcache.dart';

enum LogActionType {
  addKey,
  removeKey,
  save,
  read,
  remove,
  clear;

  String get value {
    switch (this) {
      case LogActionType.addKey:
        return "Add Key";
      case LogActionType.removeKey:
        return "Remove Key";
      case LogActionType.save:
        return "Save";
      case LogActionType.read:
        return "Read";
      case LogActionType.remove:
        return "Remove";
      case LogActionType.clear:
        return "Clear";
    }
  }
}

class LogModel {
  final String? action;
  final String? value;
  final String? time;

  LogModel({
    this.action,
    this.value,
    this.time,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        action: json["action"],
        value: json["value"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "value": value,
        "time": time,
      };
}

class LogManager {
  static LogManager? _manager;

  factory LogManager() => _manager ??= LogManager._internal();

  LogManager._internal();

  static LogManager get instance => _manager ??= LogManager._internal();

  List<LogModel> _localData = [];

  Future<List<LogModel>> data() async {
    String? s = await RCache.common.readString(key: AppRCacheKey.logs);
    if (s != null) {
      List<LogModel> data =
          List<LogModel>.from(jsonDecode(s).map((x) => LogModel.fromJson(x)));
      _localData = data;
    }
    return Future.value(_localData);
  }

  Future<void> add({
    required LogActionType action,
    required String value,
  }) async {
    String time = DateFormat("d-M-yyyy HH:mm:ss").format(DateTime.now());
    _localData.add(LogModel(action: action.value, value: value, time: time));
    List<dynamic> json = List<dynamic>.from(_localData.map((x) => x.toJson()));
    await RCache.common.saveString(jsonEncode(json), key: AppRCacheKey.logs);
  }
}
