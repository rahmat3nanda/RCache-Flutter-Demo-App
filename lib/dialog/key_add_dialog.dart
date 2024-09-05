import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyAddDialog extends StatefulWidget {
  const KeyAddDialog({super.key});

  @override
  State<KeyAddDialog> createState() => _KeyAddDialogState();
}

class _KeyAddDialogState extends State<KeyAddDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: _title(),
        content: CupertinoTextField(controller: _controller),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          CupertinoDialogAction(
            child: const Text("Save"),
            onPressed: () => Navigator.pop(context, _controller.text),
          ),
        ],
      );
    }
    return AlertDialog(
      title: _title(),
      content: TextField(controller: _controller),
      actions: [
        MaterialButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        MaterialButton(
          child: const Text("Save"),
          onPressed: () => Navigator.pop(context, _controller.text),
        ),
      ],
    );
  }

  Widget _title() {
    return const Text("Add Key", style: TextStyle(fontSize: 16.0));
  }
}

Future openKeyAddDialog(BuildContext context) {
  return showGeneralDialog(
    barrierLabel: "Add Key Dialog",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    pageBuilder: (context, anim1, anim2) => const KeyAddDialog(),
    transitionDuration: const Duration(milliseconds: 100),
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: child,
      );
    },
  );
}
