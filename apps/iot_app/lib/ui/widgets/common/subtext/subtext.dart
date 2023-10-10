import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'subtext_model.dart';

class Subtext extends StackedView<SubtextModel> {
  final String? text;
  final Color? textColor;
  final TextStyle? style;
  const Subtext({super.key, this.text, this.style, this.textColor});

  @override
  Widget builder(
    BuildContext context,
    SubtextModel viewModel,
    Widget? child,
  ) {
    return Text(
      text ?? 'none',
      style: style ??
          TextStyle(
              fontSize: 14,
              color: textColor ?? Theme.of(context).colorScheme.secondary),
      textAlign: TextAlign.left,
    );
  }

  @override
  SubtextModel viewModelBuilder(
    BuildContext context,
  ) =>
      SubtextModel();
}
