import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showCupertinoModal(
    {required BuildContext context,
    required String type,
    required List list,
    required Function(dynamic selected) onPressed,
    dynamic selected}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          onPressed(null);
        },
        child: const Text(
          'Cancel', // Assuming TransferToModel has a 'name' property
          style: TextStyle(color: Colors.grey),
        ),
      ),
      title: Text(type),
      actions: List.generate(
        list.length,
        (index) => CupertinoActionSheetAction(
          isDefaultAction: list[index].name == selected ? true : false,
          onPressed: () {
            onPressed(list[index]);
          },
          child: Text(
            list[index].name, // Assuming TransferToModel has a 'name' property
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    ),
  );
}
