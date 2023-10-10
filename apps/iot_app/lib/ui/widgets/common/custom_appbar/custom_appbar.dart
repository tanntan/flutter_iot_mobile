import 'package:flutter/material.dart';
import 'package:iot_app/ui/widget/title_widget.dart';
import 'package:stacked/stacked.dart';

import 'custom_appbar_model.dart';

class CustomAppbar extends StackedView<CustomAppbarModel> {
  final Widget? leading;
  final String? title;
  final double? expandedHeight;
  final List<Widget>? actions;
  const CustomAppbar(
      {super.key, this.title, this.actions, this.leading, this.expandedHeight});

  @override
  Widget builder(
    BuildContext context,
    CustomAppbarModel viewModel,
    Widget? child,
  ) {
    return SliverAppBar.large(
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
      expandedHeight: expandedHeight ?? 160,
      floating: false,
      pinned: true,
      snap: false,
      stretch: true,
      automaticallyImplyLeading: true,
      title: TitleWidget(
        title: title?.toUpperCase() ?? '',
      ),
      leading: leading,
      actions: actions ?? [],
    );
  }

  @override
  CustomAppbarModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomAppbarModel();
}

// SliverAppBar.large(
//       expandedHeight: 160,
//       floating: false,
//       pinned: true,
//       snap: false,
//       // leading: IconButton(
//       //   highlightColor: Colors.amber,
//       //   onPressed: model.showBottomSheet,
//       //   icon: const Icon(
//       //     Icons.person_2_rounded,
//       //   ),
//       // ),
//       title: TitleWidget(
//         title: title ?? 'AppBar',
//       ),
//       actions: [
//         horizontalSpaceSmall,
//         IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.add_rounded),
//         ),
//         horizontalSpaceSmall,
//       ],
//     );
