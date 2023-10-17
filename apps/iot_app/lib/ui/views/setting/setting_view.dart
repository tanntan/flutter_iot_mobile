import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:iot_app/ui/widget/title_widget.dart';
import 'package:iot_app/ui/widget/listItem_widget.dart';

import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'setting_viewmodel.dart';

class SettingView extends StackedView<SettingViewModel> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            title: TitleWidget(title: translate(context).ksSetting),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListItemWidget(
                          title: AppLocalizations.of(context)!.ksLanguage,
                          subtitle: Text(viewModel.languageSub?['label'] ??
                              translate(context).ksLanguage),
                          onTap: () => viewModel.languageSetting(
                              translate(context).ksLanguage, context),
                          leading: const Icon(Icons.public),
                        ),
                        ListItemWidget(
                          title: AppLocalizations.of(context)!.ksDisplayMode,
                          subtitle: const Text('Dark'),
                          onTap: viewModel.handleThemechange,
                          leading: const Icon(Icons.display_settings),
                        ),
                        ListItemWidget(
                          title: AppLocalizations.of(context)!.ksTimeZone,
                          subtitle: const Text('Dark'),
                          onTap: () => {},
                          leading: const Icon(Icons.time_to_leave),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  SettingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingViewModel();

  @override
  void onViewModelReady(SettingViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.initialize());
}
