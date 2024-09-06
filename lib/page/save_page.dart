import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcache_demo_flutter/bloc/key/key_bloc.dart';
import 'package:rcache_demo_flutter/bloc/save/save_bloc.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';
import 'package:rcache_demo_flutter/page/key_page.dart';
import 'package:rcache_demo_flutter/utils/router.dart';
import 'package:rcache_demo_flutter/widget/button_widget.dart';
import 'package:rcache_demo_flutter/widget/form_header_widget.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  late KeyBloc _keyBloc;
  late SaveBloc _saveBloc;

  DataType? _dataType;
  KeyModel? _key;
  StorageType? _storageType;

  late List<KeyModel> _keys;
  late TextEditingController _controller;
  late bool _buttonEnabled;

  @override
  void initState() {
    super.initState();
    _keyBloc = BlocProvider.of<KeyBloc>(context);
    _saveBloc = BlocProvider.of<SaveBloc>(context);
    _keys = [];
    _controller = TextEditingController();
    _buttonEnabled = false;
    _keyBloc.add(const KeyLoadEvent());
  }

  void _addKey() async {
    await route(const KeyPage());
    _keyBloc.add(const KeyLoadEvent());
  }

  void _check() {
    setState(() {
      _buttonEnabled = _dataType != null &&
          _key != null &&
          _storageType != null &&
          _controller.text.trim().isNotEmpty;
    });
  }

  void _submit() {
    String value = _controller.text.trim();

    if (value.isEmpty) {
      Fluttertoast.showToast(msg: "Cannot be Empty!");
      return;
    }

    _saveBloc.add(SaveDataEvent(
      dataType: _dataType!,
      key: _key!,
      storageType: _storageType!,
      value: value,
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
          bloc: _saveBloc,
          listener: (c, s) {
            if (s is SaveDataSuccessState) {
              _controller.text = "";
              _dataType = null;
              _key = null;
              _storageType = null;
              _check();
              Fluttertoast.showToast(msg: "Success Saving");
            } else if (s is SaveDataFailedState) {
              Fluttertoast.showToast(msg: s.message);
            }
          },
        ),
      ],
      child: BlocBuilder(
        bloc: _saveBloc,
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
                showAddKey: true,
                dataTypeChanged: (d) => setState(() {
                  _dataType = d;
                  _controller.text = "";
                  _check();
                }),
                keyChanged: (k) => setState(() {
                  _key = k;
                  _check();
                }),
                didAddKey: _addKey,
                storageTypeChanged: (s) => setState(() {
                  _storageType = s;
                  _check();
                }),
              ),
              const Divider(),
              const Text("Value:"),
              if (_dataType == DataType.boolean)
                ListTile(
                  title: const Text("TRUE"),
                  leading: Radio<String>(
                    value: "TRUE",
                    groupValue: _controller.text,
                    onChanged: (s) => setState(() {
                      _controller.text = s ?? "";
                    }),
                  ),
                ),
              if (_dataType == DataType.boolean)
                ListTile(
                  title: const Text("FALSE"),
                  leading: Radio<String>(
                    value: "FALSE",
                    groupValue: _controller.text,
                    onChanged: (s) => setState(() {
                      _controller.text = s ?? "";
                    }),
                  ),
                ),
              if (_dataType?.isUseTextField ?? false)
                TextField(
                  controller: _controller,
                  onChanged: (_) => _check(),
                )
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
