import 'package:flutter/material.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';
import 'package:rcache_demo_flutter/widget/floating_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<LogModel> _logs;

  @override
  void initState() {
    super.initState();
    _logs = [];
    _updateLogs();
  }

  void _updateLogs() async {
    List<LogModel> data = await LogManager.shared.data();
    setState(() {
      _logs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RCache"), centerTitle: false),
      body: SafeArea(child: _mainView()),
    );
  }

  Widget _mainView() {
    return FloatingMenu(
      menu: [
        FloatingActionButton(
          onPressed: () {},
          tooltip: "Clear",
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.clear),
              Text("Clear"),
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          tooltip: "Remove",
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove),
              Text("Remove"),
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          tooltip: "Read",
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.output),
              Text("Read"),
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          tooltip: "Save",
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.input),
              Text("Save"),
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {},
          tooltip: "Key",
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.key),
              Text("Key"),
            ],
          ),
        ),
      ],
      child: _logsView(),
    );
  }

  Widget _logsView() {
    if (_logs.isEmpty) {
      return const Center(child: Text("RCache"));
    }

    return ListView.separated(
      itemCount: _logs.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => Text(_logs[i].value ?? ""),
    );
  }
}
