import 'package:flutter/material.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

import 'provision_viewmodel.dart';

class ProvisionView extends StackedView<ProvisionViewModel> {
  const ProvisionView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProvisionViewModel viewModel,
    Widget? child,
  ) {
    StateMachineController getRiveController(Artboard artboard) {
      StateMachineController? controller =
          StateMachineController.fromArtboard(artboard, 'State Machine 1');
      artboard.addController(controller!);
      return controller;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: RiveAnimation.asset('assets/checkerror.riv',
                      fit: BoxFit.contain, onInit: (artboard) {
                    StateMachineController controller =
                        getRiveController(artboard);
                    viewModel.check = controller.findSMI('Check') as SMITrigger;
                    viewModel.reset = controller.findSMI('Reset') as SMITrigger;
                    viewModel.cError =
                        controller.findSMI('Error') as SMITrigger;
                  }),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: 150,
                  child: InkWell(
                    onTap: viewModel.provisionHandler,
                    child: AnimatedContainer(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 300),
                      height: viewModel.info ? 60.0 : 0.0,
                      decoration: BoxDecoration(
                        color: viewModel.info
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .background, // Adjust the color
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Subtext(
                        text: translate(context).ksHome,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  ProvisionViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProvisionViewModel();

  @override
  void onViewModelReady(ProvisionViewModel viewModel) {
    viewModel.initialize();
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }
}
