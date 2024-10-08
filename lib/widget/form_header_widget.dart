import 'package:flutter/material.dart';
import 'package:rcache_demo_flutter/model/data_type.dart';
import 'package:rcache_demo_flutter/model/key_model.dart';
import 'package:rcache_demo_flutter/model/storage_type.dart';
import 'package:rcache_demo_flutter/widget/dropdown_title_widget.dart';

class FormHeaderWidget extends StatefulWidget {
  final DataType? dataType;
  final KeyModel? keyModel;
  final StorageType? storageType;

  final bool showAddKey;
  final bool showDataType;

  final List<DataType> sourceDataType;
  final List<KeyModel> sourceKey;
  final List<StorageType> sourceStorageType;

  final Function(DataType?)? dataTypeChanged;
  final Function(KeyModel?)? keyChanged;
  final Function()? didAddKey;
  final Function(StorageType?)? storageTypeChanged;

  const FormHeaderWidget({
    super.key,
    this.dataType,
    required this.keyModel,
    required this.storageType,
    this.showAddKey = false,
    this.showDataType = true,
    required this.sourceDataType,
    required this.sourceKey,
    required this.sourceStorageType,
    this.dataTypeChanged,
    this.keyChanged,
    this.didAddKey,
    this.storageTypeChanged,
  });

  @override
  State<FormHeaderWidget> createState() => _FormHeaderWidgetState();
}

class _FormHeaderWidgetState extends State<FormHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showDataType)
          DropdownTitleWidget(
            selected: widget.dataType,
            title: "Data Type:",
            hint: "Select Data Type",
            sources: widget.sourceDataType,
            label: (i) => i.value,
            onChanged: (i) {
              if (widget.dataTypeChanged != null) {
                widget.dataTypeChanged!(i);
              }
            },
          ),
        DropdownTitleWidget(
          selected: widget.keyModel,
          title: "Key:",
          hint: "Select Key",
          sources: widget.sourceKey,
          label: (i) => i.name,
          onChanged: (i) {
            if (widget.keyChanged != null) {
              widget.keyChanged!(i);
            }
          },
          suffix: !widget.showAddKey
              ? null
              : IconButton(
                  onPressed: widget.didAddKey,
                  icon: const Icon(Icons.add),
                ),
        ),
        DropdownTitleWidget(
          selected: widget.storageType,
          title: "Storage Type:",
          hint: "Select Storage Type",
          sources: widget.sourceStorageType,
          label: (i) => i.value,
          onChanged: (i) {
            if (widget.storageTypeChanged != null) {
              widget.storageTypeChanged!(i);
            }
          },
        ),
      ],
    );
  }
}
