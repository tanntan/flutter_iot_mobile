// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final String title;
  final Widget? leading, subtitle;
  final GestureTapCallback? onTap;

  const ListItemWidget(
      {super.key,
      required this.title,
      this.leading,
      this.subtitle,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      subtitle: subtitle,
      title: Text(
        title.isEmpty ? "Setting" : title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }
}
