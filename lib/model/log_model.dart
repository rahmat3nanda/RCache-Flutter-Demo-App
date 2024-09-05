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
