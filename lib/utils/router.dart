import 'package:flutter/material.dart';

extension BuildContextRouter on BuildContext {
  Future route(Widget destination) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => destination),
    );
  }
}

extension StateRouter on State {
  Future route(Widget destination) {
    return context.route(destination);
  }
}
