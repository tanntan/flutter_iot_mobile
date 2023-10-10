import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:iot_app/ui/widgets/common/custom_list/custom_list.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';

import 'add_device_viewmodel.dart';

class AddDeviceView extends StackedView<AddDeviceViewModel> {
  const AddDeviceView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddDeviceViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: viewModel.connectBle,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.only(bottom: 10),
          child: AnimatedContainer(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            duration: Duration(milliseconds: 300),
            height: viewModel.getList.isNotEmpty ? 60.0 : 0.0,
            decoration: BoxDecoration(
              color: viewModel.getList.isNotEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context)
                      .colorScheme
                      .background, // Adjust the color
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Subtext(
              text: viewModel.getList.isNotEmpty
                  ? '${translate(context).ksSelected} (${viewModel.getList.length})'
                  : 'Not selected',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.background),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomAppbar(
            title: translate(context).ksAddDevice,
            actions: [
              viewModel.getList.isNotEmpty
                  ? TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                Theme.of(context).colorScheme.primaryContainer),
                        padding: MaterialStateProperty.resolveWith((states) =>
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                      ),
                      onPressed: viewModel.deselectall,
                      icon: Icon(Icons.close),
                      label: Subtext(
                        text: translate(context).ksDeselectAll,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ))
                  : Container(),
              IconButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                        (state) => EdgeInsets.all(10)),
                    backgroundColor: MaterialStateColor.resolveWith((states) =>
                        Theme.of(context).colorScheme.primaryContainer)),
                onPressed: viewModel.reloadHandler,
                icon: Icon(Icons.refresh),
              ),
            ],
          ),
          viewModel.dataReady
              ? SliverPadding(
                  padding: EdgeInsets.all(15),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15.0,
                    children: viewModel.bleDevices
                        .map((device) => CustomList(
                              device: device,
                              selectHandler: viewModel.selecthalder,
                              isSelected: !viewModel.getList.contains(device),
                            ))
                        .toList(),
                  ))
              : SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                        ),
                        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SpinKitDoubleBounce(
                              duration: Duration(seconds: 3),
                              color: Theme.of(context).colorScheme.error,
                              size: 20,
                            ),
                            horizontalSpaceSmall,
                            Subtext(
                              text: translate(context).ksAutodetect,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned(
                            child: Center(
                              child: SpinKitDoubleBounce(
                                duration: Duration(seconds: 5),
                                color: Theme.of(context)
                                    .colorScheme
                                    .errorContainer,
                                size: 150,
                              ),
                            ),
                          ),
                          const Positioned(
                            top: 0,
                            left: 130,
                            child: Center(
                              child: Icon(
                                Icons.phone_android_sharp,
                                size: 150,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Subtext(
                          text: translate(context).ksAutodetect,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  @override
  AddDeviceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AddDeviceViewModel();

  @override
  void onViewModelReady(AddDeviceViewModel viewModel) {
    viewModel.initial();
    super.onViewModelReady(viewModel);
  }
}
