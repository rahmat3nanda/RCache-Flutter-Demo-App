import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcache_demo_flutter/bloc/key/key_bloc.dart';
import 'package:rcache_demo_flutter/dialog/key_add_dialog.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';

class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  State<KeyPage> createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  late KeyBloc _bloc;
  late List<KeyModel> _data;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<KeyBloc>(context);
    _data = [];
    _bloc.add(const KeyLoadEvent());
  }

  void _addKey() async {
    String? s = await openKeyAddDialog(context);
    if (s == null) {
      return;
    }

    if (s.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Cannot be Empty!");
      return;
    }

    _bloc.add(KeyAddEvent(s.trim()));
  }

  void _deleteKey(int index) {
    KeyModel item = _data[index];
    setState(() {
      _data.remove(item);
    });
    _bloc.add(KeyDeleteEvent(item));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) {
        if (s is KeyLoadSuccessState) {
          _data = s.data;
        } else if (s is KeyLoadFailedState) {
          Fluttertoast.showToast(msg: "Failed Load Data");
        } else if (s is KeyAddSuccessState) {
          _data = s.data;
          Fluttertoast.showToast(msg: "Success Add Data");
        } else if (s is KeyAddFailedState) {
          Fluttertoast.showToast(msg: "Failed Add Data");
        } else if (s is KeyDeleteSuccessState) {
          _data = s.data;
          Fluttertoast.showToast(msg: "Success Delete Data");
        } else if (s is KeyDeleteFailedState) {
          Fluttertoast.showToast(msg: "Failed Delete Data");
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return Scaffold(
            appBar: AppBar(title: const Text("RCache: Key")),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: _addKey,
              tooltip: "Add",
              child: const Icon(Icons.add),
            ),
            body: _mainView(),
          );
        },
      ),
    );
  }

  Widget _mainView() {
    if (_data.isEmpty) {
      return const Center(child: Text("Empty"));
    }

    return ListView.separated(
      itemCount: _data.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => Dismissible(
        key: Key(_data[i].name),
        background: Container(color: Colors.transparent),
        secondaryBackground: Container(
          color: Colors.red,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 12),
              Icon(Icons.delete_forever, color: Colors.white),
            ],
          ),
        ),
        confirmDismiss: (d) => Future.value(d == DismissDirection.endToStart),
        onDismissed: (_) => _deleteKey(i),
        child: ListTile(title: Text(_data[i].name), minTileHeight: 36),
      ),
    );
  }
}
