import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';

import 'custom_list_model.dart';

class CustomList extends StackedView<CustomListModel> {
  final BluetoothDevice? device;
  final bool? isSelected;
  final void Function(BluetoothDevice)? selectHandler;
  const CustomList(
      {super.key, this.device, this.selectHandler, this.isSelected});

  @override
  Widget builder(
    BuildContext context,
    CustomListModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => selectHandler!(device!),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          backgroundBlendMode: null,
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surfaceVariant,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).cardColor,
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  isSelected ?? true ? Icons.circle : Icons.check_circle,
                  color: isSelected ?? true
                      ? Theme.of(context).colorScheme.surfaceVariant
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              device!.localName.isEmpty
                  ? Icon(
                      Icons.question_mark,
                      size: 50,
                      color: Theme.of(context).colorScheme.error,
                    )
                  : Image.network(
                      'https://sensiml.com/documentation/_images/m5stickc-plus-device.png',
                      width: 80,
                      height: 80,
                    ),
              verticalSpaceSmall,
              Text(
                device!.localName.isEmpty
                    ? translate(context).ksUnknown
                    : device!.localName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
      ),
    );
  }

  @override
  CustomListModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomListModel();
}
