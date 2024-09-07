import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rcache_demo_flutter/bloc/clear/clear_bloc.dart';
import 'package:rcache_demo_flutter/model/clear_type.dart';
import 'package:rcache_demo_flutter/widget/button_widget.dart';
import 'package:rcache_demo_flutter/widget/dropdown_title_widget.dart';

class ClearPage extends StatefulWidget {
  const ClearPage({super.key});

  @override
  State<ClearPage> createState() => _ClearPageState();
}

class _ClearPageState extends State<ClearPage> {
  late ClearBloc _bloc;

  ClearType? _clearType;

  late bool _buttonEnabled;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ClearBloc>(context);
    _buttonEnabled = false;
  }

  void _check() {
    _buttonEnabled = _clearType != null;
  }

  void _submit() {
    _bloc.add(ClearDataEvent(_clearType!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _bloc,
      listener: (c, s) {
        if (s is ClearDataSuccessState) {
          Fluttertoast.showToast(
            msg: "Success Clear ${_clearType?.value}!",
          );
          _clearType = null;
          _check();
        } else if (s is ClearDataFailedState) {
          Fluttertoast.showToast(msg: s.message);
        }
      },
      child: BlocBuilder(
        bloc: _bloc,
        builder: (c, s) {
          return Scaffold(
            appBar: AppBar(title: const Text("RCache: Clear")),
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
              DropdownTitleWidget(
                selected: _clearType,
                title: "Clear Type",
                hint: "Select Clear Type",
                sources: ClearType.values,
                label: (i) => i.value,
                onChanged: (i) => setState(() {
                  _clearType = i;
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
              "Clear",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
