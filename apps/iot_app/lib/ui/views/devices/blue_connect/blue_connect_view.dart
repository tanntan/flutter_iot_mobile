import 'package:flutter/material.dart';
import 'package:iot_app/core/model/BleDevice_model.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/widget/title_widget.dart';
import 'package:iot_app/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:iot_app/ui/widgets/common/custom_dropdown_search/custom_dropdown_search.dart';
import 'package:iot_app/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';

import 'blue_connect_viewmodel.dart';

class BlueConnectView extends StackedView<BlueConnectViewModel> {
  final List<BleDevice>? argument;
  const BlueConnectView({Key? key, this.argument}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BlueConnectViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.submitHandler,
        child: const Icon(Icons.arrow_forward_ios_outlined),
      ),
      body: CustomScrollView(
        slivers: [
          CustomAppbar(
            title: translate(context).ksParameter,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                viewModel.deviceWithparam
                    .map((device) => Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 15.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: TitleWidget(
                                  title: device.device!.localName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceTint,
                                  ),
                                ),
                              ),
                              verticalSpaceMedium,
                              CustomTextField(
                                onChangeHandler: (value) {
                                  device.params.deviceName = value;
                                },
                                prefexIcon: const Icon(Icons.devices),
                                label: translate(context).ksDeviceName,
                              ),
                              verticalSpaceMedium,
                              CustomDropdownSearch(
                                label: translate(context).ksSelectLine,
                                hintText: translate(context).ksSelectLine,
                                onChange: (value) {
                                  device.params.line = value!.lineName;
                                },
                                datas: viewModel.allLineData,
                                prefexIcon: const Icon(Icons.area_chart),
                              ),
                              verticalSpaceMedium,
                              CustomTextField(
                                prefexIcon: const Icon(Icons.engineering),
                                type: TextInputType.number,
                                onChangeHandler: (value) {
                                  device.params.station = int.parse(value);
                                },
                                label: translate(context).ksStation,
                              ),
                              verticalSpaceMedium,
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  BlueConnectViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BlueConnectViewModel();

  @override
  void onViewModelReady(BlueConnectViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }
}
