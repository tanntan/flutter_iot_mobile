import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final TextStyle? style;
  const TitleWidget({super.key, required this.title, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ??
          TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );
  }
}
