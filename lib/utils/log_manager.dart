import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:rcache_demo_flutter/app_rcache_key.dart';
import 'package:rcache_demo_flutter/model/log_model.dart';
import 'package:rcache_flutter/rcache.dart';

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
