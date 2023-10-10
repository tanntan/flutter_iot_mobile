import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

import 'loading_animation_model.dart';

class LoadingAnimation extends StackedView<LoadingAnimationModel> {
  final Function(Artboard)? init;
  const LoadingAnimation({super.key, this.init});

  @override
  Widget builder(
    BuildContext context,
    LoadingAnimationModel viewModel,
    Widget? child,
  ) {
    return RiveAnimation.asset(
      'assets/checkerror.riv',
      fit: BoxFit.contain,
      onInit: init ?? (Artboard) {},
    );
  }

  @override
  LoadingAnimationModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoadingAnimationModel();
}
