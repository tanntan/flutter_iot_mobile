import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_options_model.dart';

class CustomOptions extends StackedView<CustomOptionsModel> {
  const CustomOptions({super.key});

  @override
  Widget builder(
    BuildContext context,
    CustomOptionsModel viewModel,
    Widget? child,
  ) {
    return const SizedBox.shrink();
  }

  @override
  CustomOptionsModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomOptionsModel();
}
