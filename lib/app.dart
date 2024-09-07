import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rcache_demo_flutter/bloc/clear/clear_bloc.dart';
import 'package:rcache_demo_flutter/bloc/key/key_bloc.dart';
import 'package:rcache_demo_flutter/bloc/read/read_bloc.dart';
import 'package:rcache_demo_flutter/bloc/remove/remove_bloc.dart';
import 'package:rcache_demo_flutter/bloc/save/save_bloc.dart';
import 'package:rcache_demo_flutter/page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ClearBloc>(
          create: (BuildContext context) => ClearBloc(ClearInitialState()),
        ),
        BlocProvider<KeyBloc>(
          create: (BuildContext context) => KeyBloc(KeyInitialState()),
        ),
        BlocProvider<ReadBloc>(
          create: (BuildContext context) => ReadBloc(ReadInitialState()),
        ),
        BlocProvider<RemoveBloc>(
          create: (BuildContext context) => RemoveBloc(RemoveInitialState()),
        ),
        BlocProvider<SaveBloc>(
          create: (BuildContext context) => SaveBloc(SaveInitialState()),
        ),
      ],
      child: MaterialApp(
        title: 'RCache Flutter Demo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
