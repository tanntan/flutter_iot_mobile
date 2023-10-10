import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'thridparty_viewmodel.dart';

class ThridpartyView extends StackedView<ThridpartyViewModel> {
  const ThridpartyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ThridpartyViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      child: Text(viewModel.data ?? 'Hello'),
    );
  }

  @override
  ThridpartyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ThridpartyViewModel();

  @override
  void onViewModelReady(ThridpartyViewModel viewModel) {
    // TODO: implement onViewModelReady
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }
}
