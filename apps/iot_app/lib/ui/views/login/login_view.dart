import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/widget/title_widget.dart';
import 'package:iot_app/ui/widgets/common/custom_button/custom_button.dart';
import 'package:iot_app/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:iot_app/ui/widgets/common/loading_animation/loading_animation.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LoginViewModel viewModel,
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            backgroundColor: Theme.of(context).colorScheme.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/landingcompany.png',
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () =>
                      viewModel.languageSetting('Language', context),
                  icon: const Icon(Icons.language_rounded))
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surfaceVariant),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            HeaderLogo(
                              title: 'ltlabs',
                              logo: Image.asset(
                                'assets/headerlogo.png',
                                width: 25,
                                height: 25,
                              ),
                              subtitle:
                                  translate(context).ksSiginYourltlabsAccount,
                            ),
                            // viewModel.loginInfo == null
                            //     ? Container()
                            //     : Subtext(
                            //         text: viewModel.loginInfo?.toString(),
                            //         style: TextStyle(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .error),
                            //       ),
                            TextField(
                              onSubmitted: (value) {
                                viewModel.loginCompany();
                              },
                              inputFormatters: [UpperCaseTextFormatter()],
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: viewModel.onValue,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                label: Subtext(
                                  text: translate(context).ksCompanyName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                border: const UnderlineInputBorder(),
                              ),
                            ),
                            verticalSpaceMedium,
                            InkWell(
                              onTap: viewModel.loginCompany,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Center(
                                  child: Subtext(
                                    text: translate(context).ksLoginCompany,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          child: Center(
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: viewModel.isLoginSuccess ?? false
                                  ? LoadingAnimation(
                                      init: (artboard) {
                                        StateMachineController controller =
                                            getRiveController(artboard);
                                        viewModel.check = controller
                                            .findSMI('Check') as SMITrigger;
                                        viewModel.reset = controller
                                            .findSMI('Reset') as SMITrigger;
                                        viewModel.cError = controller
                                            .findSMI('Error') as SMITrigger;
                                      },
                                    )
                                  : Container(),
                            ),
                          ),
                        ),
                        viewModel.isSubmitted ?? false
                            ? AnimatedOpacity(
                                duration: const Duration(seconds: 1),
                                opacity:
                                    viewModel.isSubmitted ?? false ? 1.0 : 0,
                                child: Stack(children: [
                                  Column(
                                    children: [
                                      LoginPanel(
                                        username: CustomTextField(
                                          onChangeHandler: (String value) {
                                            viewModel.loginModel.username =
                                                value;
                                          },
                                          label: translate(context).ksUsername,
                                          prefexIcon: const Icon(Icons.person),
                                          secure: false,
                                        ),
                                        password: CustomTextField(
                                          onChangeHandler: (String value) {
                                            viewModel.loginModel.password =
                                                value;
                                          },
                                          label: translate(context).ksPassword,
                                          prefexIcon: const Icon(Icons.lock),
                                          secure: true,
                                        ),
                                      ),
                                      CustomButton(
                                        onTab: viewModel.userLogin,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    child: Center(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: viewModel.isLoginSuccess ?? false
                                            ? LoadingAnimation(
                                                init: (artboard) {
                                                  StateMachineController
                                                      controller =
                                                      getRiveController(
                                                          artboard);
                                                  viewModel.check = controller
                                                          .findSMI('Check')
                                                      as SMITrigger;
                                                  viewModel.reset = controller
                                                          .findSMI('Reset')
                                                      as SMITrigger;
                                                  viewModel.cError = controller
                                                          .findSMI('Error')
                                                      as SMITrigger;
                                                },
                                              )
                                            : Container(),
                                      ),
                                    ),
                                  ),
                                ]),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: viewModel.changeCompany,
                    child: Text(translate(context).ksLoginWithOther),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }
}

class HeaderLogo extends StatelessWidget {
  final Image? logo;
  final String? title;
  final String? subtitle;

  const HeaderLogo({super.key, this.logo, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo ?? Image.asset('assets/logo/headerlogo.png'),
          horizontalSpaceSmall,
          TitleWidget(
            title: title!.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w900,
              fontSize: 22,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
      Subtext(
        text: subtitle ?? 'Description',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      )
    ]);
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LoginPanel extends StackedView<LoginViewModel> {
  final CustomTextField? username, password;
  const LoginPanel({super.key, this.username, this.password});

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          Column(
            children: [
              HeaderLogo(
                title: 'ltlabs',
                logo: Image.asset(
                  'assets/headerlogo.png',
                  width: 25,
                  height: 25,
                ),
                subtitle: translate(context).ksSiginYourltlabsAccount,
              ),
              verticalSpaceSmall,
              username ?? const TextField(),
              verticalSpaceSmall,
              password ?? const TextField(),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) => {},
                    semanticLabel: 'Remember me',
                  ),
                  const Subtext(
                    text: 'Remember me',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LoginViewModel();
}
