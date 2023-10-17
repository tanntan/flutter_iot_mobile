import 'package:flutter/material.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/widget/listItem_widget.dart';
import 'package:iot_app/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const CustomAppbar(
            title: '',
            expandedHeight: 0.0,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          child: Icon(
                            Icons.person,
                            size: 50,
                          ),
                        ),
                        horizontalSpaceSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mr. Tann Tan',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              'Production Manager',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  verticalSpaceLarge,
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
                          title: AppLocalizations.of(context)!.ksSetting,
                          onTap: viewModel.handleSettingMenu,
                          leading: const Icon(Icons.settings),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
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
                          title: AppLocalizations.of(context)!.ksSignOut,
                          onTap: () => {},
                          leading: const Icon(Icons.exit_to_app_rounded),
                          subtitle: const Text('Sign only user data'),
                        ),
                        ListItemWidget(
                          title: AppLocalizations.of(context)!.ksCompanySignOut,
                          onTap: viewModel.logoutCompany,
                          leading: const Icon(Icons.logout),
                          subtitle: const Text('Delete Company data'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
