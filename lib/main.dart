import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcache_demo_flutter/app.dart';
import 'package:rcache_demo_flutter/bloc/observer.dart';

void main() {
  Bloc.observer = Observer();
  runApp(const App());
}
