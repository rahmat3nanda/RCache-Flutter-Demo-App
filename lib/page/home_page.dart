import 'package:flutter/material.dart';
import 'package:rcache_demo_flutter/model/log_model.dart';
import 'package:rcache_demo_flutter/page/key_page.dart';
import 'package:rcache_demo_flutter/page/save_page.dart';
import 'package:rcache_demo_flutter/utils/log_manager.dart';
import 'package:rcache_demo_flutter/utils/router.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isMenuOpen;
  late Duration _duration;
  late List<LogModel> _logs;

  @override
  void initState() {
    super.initState();
    _isMenuOpen = false;
    _duration = const Duration(milliseconds: 200);
    _logs = [];
    _updateLogs();
  }

  void _updateLogs() async {
    List<LogModel> data = await LogManager.instance.data();
    setState(() {
      _logs = data.reversed.toList();
    });
  }

  void _route(Widget destination) async {
    await route(destination);
    _updateLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RCache"), centerTitle: false),
      floatingActionButton: _fab(),
      body: SafeArea(child: _mainView()),
    );
  }

  Widget _mainView() {
    if (_logs.isEmpty) {
      return const Center(child: Text("RCache"));
    }

    return ListView.separated(
      itemCount: _logs.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) {
        LogModel log = _logs[i];
        return Text(
          "Date: ${log.time}\nAction: ${log.action}\nValue: ${log.value}",
        );
      },
    );
  }

  Widget _fab() {
    return SpeedDial(
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      tooltip: "Menu",
      spaceBetweenChildren: 12,
      animationDuration: _duration,
      onOpen: () => setState(() {
        _isMenuOpen = true;
      }),
      onClose: () => setState(() {
        _isMenuOpen = false;
      }),
      children: [
        SpeedDialChild(
          onTap: () => _route(const KeyPage()),
          shape: const CircleBorder(),
          child: const Icon(Icons.key),
          label: "Key",
        ),
        SpeedDialChild(
          onTap: () => _route(const SavePage()),
          shape: const CircleBorder(),
          child: const Icon(Icons.input),
          label: "Save",
        ),
        SpeedDialChild(
          onTap: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.output),
          label: "Read",
        ),
        SpeedDialChild(
          onTap: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.remove),
          label: "Remove",
        ),
        SpeedDialChild(
          onTap: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.clear),
          label: "Clear",
        ),
      ],
      child: AnimatedRotation(
        turns: _isMenuOpen ? 0.25 : 0,
        duration: _duration,
        child: const Icon(Icons.menu),
      ),
    );
  }
}
