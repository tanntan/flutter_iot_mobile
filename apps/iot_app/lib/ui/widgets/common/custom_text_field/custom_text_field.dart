import 'package:flutter/material.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:stacked/stacked.dart';

import 'custom_text_field_model.dart';

class CustomTextField extends StackedView<CustomTextFieldModel> {
  final String? label;
  final Icon? prefexIcon;
  final TextEditingController? controller;
  final void Function(String)? onChangeHandler;
  final void Function(String)? onSubmitChange;
  final TextInputType? type;
  final bool? secure;
  const CustomTextField({
    super.key,
    this.type,
    this.onChangeHandler,
    this.controller,
    this.label,
    this.prefexIcon,
    this.secure,
    this.onSubmitChange,
  });

  @override
  Widget builder(
    BuildContext context,
    CustomTextFieldModel viewModel,
    Widget? child,
  ) {
    // return TextField(
    //   onSubmitted: onSubmitChange,
    //   onChanged: onChangeHandler,
    //   onTapOutside: (event) {
    //     FocusManager.instance.primaryFocus?.unfocus();
    //   },
    //   obscureText: secure ?? false,
    //   // controller: controller ?? TextEditingController(text: 'controller'),
    //   style: TextStyle(
    //     fontWeight: FontWeight.bold,
    //     color: Theme.of(context).colorScheme.inverseSurface,
    //   ),
    //   decoration: InputDecoration(
    //     contentPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    //     label: Subtext(
    //       text: label ?? 'label',
    //     ),
    //     filled: false,
    //     fillColor: Theme.of(context).colorScheme.surfaceVariant,
    //     prefixIconColor: Theme.of(context).colorScheme.primary,
    //     enabledBorder: OutlineInputBorder(
    //         borderRadius: BorderRadius.circular(50),
    //         borderSide: BorderSide(
    //             width: 0.0,
    //             color: Theme.of(context).colorScheme.inverseSurface)),
    //     prefixIcon: prefexIcon ?? Icon(Icons.edit),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
    //   ),
    // );
    return TextField(
      onSubmitted: onSubmitChange,
      onChanged: onChangeHandler,
      obscureText: secure ?? false,
      keyboardType: type ?? TextInputType.text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.inverseSurface,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        //   onSubmitted: o
        label: Subtext(
          text: label ?? '',
        ),
        hintText: label ?? '', // Placeholder text
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 12.0), // Padding inside the field
        prefixIcon: prefexIcon ?? const Icon(Icons.person), // Leading icon
      ),
    );
  }

  @override
  CustomTextFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTextFieldModel();
}
