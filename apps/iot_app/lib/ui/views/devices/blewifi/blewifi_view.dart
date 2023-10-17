import 'package:flutter/material.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:iot_app/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';

import 'blewifi_viewmodel.dart';

class BlewifiView extends StackedView<BlewifiViewModel> {
  const BlewifiView({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BlewifiViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: CustomScrollView(
        slivers: [
          CustomAppbar(
            title: translate(context).ksWifiConnect,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  CustomTextField(
                    onChangeHandler: (value) {
                      viewModel.wifiController['ssid'] = value;
                    },
                    prefexIcon: const Icon(Icons.wifi),
                    label: translate(context).ksSsid,
                  ),
                  verticalSpaceMedium,
                  CustomTextField(
                    onChangeHandler: (value) {
                      viewModel.wifiController['password'] = value;
                    },
                    secure: true,
                    prefexIcon: const Icon(Icons.lock),
                    label: translate(context).ksPassword,
                  ),
                  verticalSpaceLarge,
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith(
                              (states) => const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                          ),
                          onPressed: viewModel.handleCancel,
                          child: Subtext(
                            text: translate(context).ksCancel,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.error),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                (states) => const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                              ),
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Theme.of(context).colorScheme.primary)),
                          onPressed: viewModel.provisionBle,
                          child: Subtext(
                            text: translate(context).ksProvision,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                        horizontalSpaceSmall,
                      ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  BlewifiViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BlewifiViewModel();

  @override
  void onViewModelReady(BlewifiViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }
}
