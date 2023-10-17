import 'package:flutter/material.dart';
import 'package:iot_app/ui/widget/title_widget.dart';
import 'package:stacked/stacked.dart';

import 'custom_button_model.dart';

class CustomButton extends StackedView<CustomButtonModel> {
  final Function()? onTab;
  const CustomButton({super.key, this.onTab});

  @override
  Widget builder(
    BuildContext context,
    CustomButtonModel viewModel,
    Widget? child,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: onTab,
        child: Container(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          child: TitleWidget(
            title: 'Login',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  CustomButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomButtonModel();
}
