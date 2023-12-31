// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RadioGroupWidget extends StatefulWidget {
  final List<Map<String, dynamic>>? radioList;
  final String? language;
  final void Function(String?)? handler;

  const RadioGroupWidget(
      {super.key, this.radioList, this.language, this.handler});

  @override
  State<RadioGroupWidget> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroupWidget> {
  // ignore: prefer_typing_uninitialized_variables
  var _language;
  @override
  Widget build(BuildContext context) {
    return widget.radioList!.isEmpty
        // ignore: prefer_const_constructors
        ? Text('No List')
        : Column(
            children: widget.radioList!.map(
              (dynamic item) {
                return RadioListTile<String>(
                  value: item['value'],
                  groupValue: _language ?? widget.language,
                  onChanged: (value) {
                    widget.handler!(value);
                    setState(() {
                      _language = value!;
                    });
                  },
                  title: Text(item['label'].toString()),
                );
              },
            ).toList(),
          );
  }
}
