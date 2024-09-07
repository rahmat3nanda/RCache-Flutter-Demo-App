import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcache_demo_flutter/bloc/key/key_bloc.dart';
import 'package:rcache_demo_flutter/bloc/read/read_bloc.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';
import 'package:rcache_demo_flutter/widget/button_widget.dart';
import 'package:rcache_demo_flutter/widget/form_header_widget.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  late KeyBloc _keyBloc;
  late ReadBloc _readBloc;

  DataType? _dataType;
  KeyModel? _key;
  StorageType? _storageType;

  late List<KeyModel> _keys;
  late String _result;
  late bool _buttonEnabled;

  @override
  void initState() {
    super.initState();
    _keyBloc = BlocProvider.of<KeyBloc>(context);
    _readBloc = BlocProvider.of<ReadBloc>(context);
    _keys = [];
    _result = "";
    _buttonEnabled = false;
    _keyBloc.add(const KeyLoadEvent());
  }

  void _check() {
    setState(() {
      _buttonEnabled =
          _dataType != null && _key != null && _storageType != null;
    });
  }

  void _submit() {
    _readBloc.add(ReadDataEvent(
      dataType: _dataType!,
      key: _key!,
      storageType: _storageType!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          bloc: _keyBloc,
          listener: (c, s) {
            if (s is KeyLoadSuccessState) {
              setState(() {
                _keys = s.data;

                if (!_keys.contains(_key)) {
                  _key = null;
                }
              });
            }
          },
        ),
        BlocListener(
          bloc: _readBloc,
          listener: (c, s) {
            if (s is ReadDataSuccessState) {
              _result = s.value ?? "null";
              _check();
            } else if (s is ReadDataFailedState) {
              Fluttertoast.showToast(msg: s.message);
            }
          },
        ),
      ],
      child: BlocBuilder(
        bloc: _readBloc,
        builder: (c, s) {
          return Scaffold(
            appBar: AppBar(title: const Text("RCache: Save")),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: _mainView(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _mainView() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              FormHeaderWidget(
                dataType: _dataType,
                keyModel: _key,
                storageType: _storageType,
                sourceDataType: DataType.values,
                sourceKey: _keys,
                sourceStorageType: StorageType.values,
                dataTypeChanged: (d) => setState(() {
                  _dataType = d;
                  _check();
                }),
                keyChanged: (k) => setState(() {
                  _key = k;
                  _check();
                }),
                storageTypeChanged: (s) => setState(() {
                  _storageType = s;
                  _check();
                }),
              ),
              const Divider(),
              Text("Result:\n$_result"),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ButtonWidget(
          isActive: _buttonEnabled,
          onTap: _submit,
          width: double.infinity,
          child: const Center(
            child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
