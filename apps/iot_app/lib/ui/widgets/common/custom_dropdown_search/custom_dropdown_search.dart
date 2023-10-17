import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:stacked/stacked.dart';

import 'custom_dropdown_search_model.dart';

class CustomDropdownSearch extends StackedView<CustomDropdownSearchModel> {
  final List<DataModel>? datas;
  final void Function(DataModel?)? onChange;
  final String? label, hintText;
  final Widget? prefexIcon;
  const CustomDropdownSearch(
      {super.key,
      this.datas,
      this.onChange,
      this.prefexIcon,
      this.hintText,
      this.label});

  @override
  Widget builder(
    BuildContext context,
    CustomDropdownSearchModel viewModel,
    Widget? child,
  ) {
    return DropdownSearch<DataModel>(
      onChanged: onChange,
      itemAsString: (item) {
        return item.lineName ?? '';
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          //   onSubmitted: o
          label: Subtext(
            text: label ?? 'label',
          ),
          hintText: hintText ?? 'Hint', // Placeholder text
          filled: true,
          fillColor:
              Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              )),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 12.0), // Padding inside the field
          prefixIcon: prefexIcon ?? const Icon(Icons.person), // Leading icon
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear), // Trailing icon for clearing text
            onPressed: () {},
          ),
        ),
      ),
      autoValidateMode: AutovalidateMode.always,
      items: datas ?? [],
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        listViewProps: const ListViewProps(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(20),
        ),
        menuProps: MenuProps(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(20),
        ),
        showSearchBox: true,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: UnderlineInputBorder(),
            label: Subtext(
              text: 'Line name',
            ),
          ),
        ),
        itemBuilder: (context, DataModel item, isSelected) {
          return DropdownMenuItem(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Subtext(
              text: item.lineName,
            ),
          ));
        },
      ),
    );
  }

  @override
  CustomDropdownSearchModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomDropdownSearchModel();
}
