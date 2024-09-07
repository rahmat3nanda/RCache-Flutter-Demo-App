import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcache_demo_flutter/bloc/key/key_bloc.dart';
import 'package:rcache_demo_flutter/bloc/read/read_bloc.dart';
import 'package:rcache_demo_flutter/bloc/remove/remove_bloc.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';
import 'package:rcache_demo_flutter/widget/button_widget.dart';
import 'package:rcache_demo_flutter/widget/form_header_widget.dart';

class RemovePage extends StatefulWidget {
  const RemovePage({super.key});

  @override
  State<RemovePage> createState() => _RemovePageState();
}

class _RemovePageState extends State<RemovePage> {
  late KeyBloc _keyBloc;
  late RemoveBloc _removeBloc;

  KeyModel? _key;
  StorageType? _storageType;

  late List<KeyModel> _keys;
  late bool _buttonEnabled;

  @override
  void initState() {
    super.initState();
    _keyBloc = BlocProvider.of<KeyBloc>(context);
    _removeBloc = BlocProvider.of<RemoveBloc>(context);
    _keys = [];
    _buttonEnabled = false;
    _keyBloc.add(const KeyLoadEvent());
  }

  void _check() {
    setState(() {
      _buttonEnabled = _key != null && _storageType != null;
    });
  }

  void _submit() {
    _removeBloc.add(RemoveDataEvent(
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
          bloc: _removeBloc,
          listener: (c, s) {
            if (s is RemoveDataSuccessState) {
              Fluttertoast.showToast(
                msg:
                    "Success remove variable with key ${_key?.name} from ${_storageType?.value}",
              );
              _key = null;
              _storageType = null;
              _check();
            } else if (s is ReadDataFailedState) {
              Fluttertoast.showToast(msg: s.message);
            }
          },
        ),
      ],
      child: BlocBuilder(
        bloc: _removeBloc,
        builder: (c, s) {
          return Scaffold(
            appBar: AppBar(title: const Text("RCache: Remove")),
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
                keyModel: _key,
                storageType: _storageType,
                showDataType: false,
                sourceDataType: DataType.values,
                sourceKey: _keys,
                sourceStorageType: StorageType.values,
                keyChanged: (k) => setState(() {
                  _key = k;
                  _check();
                }),
                storageTypeChanged: (s) => setState(() {
                  _storageType = s;
                  _check();
                }),
              ),
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
