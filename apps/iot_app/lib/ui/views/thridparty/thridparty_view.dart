import 'package:flutter/material.dart';
import 'package:iot_app/core/model/entities_model.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/ui/widget/title_widget.dart';

import 'package:iot_app/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';

import 'thridparty_viewmodel.dart';

class ThridpartyView extends StackedView<ThridpartyViewModel> {
  const ThridpartyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ThridpartyViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          shape: CircleBorder(),
        ),
        body: CustomScrollView(
          slivers: [
            CustomAppbar(
              title: translate(context).ksAddDevice, // this is title
              actions: [
                IconButton(
                    onPressed: viewModel.handleGridChange,
                    icon: Icon(viewModel.isGridView
                        ? Icons.list_rounded
                        : Icons.grid_view_rounded)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: viewModel.dataReady
                  ? viewModel.isGridView
                      ? SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                          ),
                          itemBuilder: (context, index) =>
                              CustomGridView(entity: viewModel.data?[index]),
                          itemCount: viewModel.data?.length ?? 0,
                        )
                      : SliverList.builder(
                          itemBuilder: (context, index) => Container(
                            child:
                                CustomListTile(entity: viewModel.data?[index]),
                          ),
                          itemCount: viewModel.data?.length ?? 0,
                        )
                  : SliverToBoxAdapter(
                      child: Container(
                        child: Text('No data'),
                      ),
                    ),
            ),
          ],
        ));
  }

  @override
  ThridpartyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ThridpartyViewModel();

  @override
  void onViewModelReady(ThridpartyViewModel viewModel) {
    // TODO: implement onViewModelReady
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }
}

class CustomListTile extends StatelessWidget {
  final EntitiesModel? entity;
  final bool? isGridView;
  CustomListTile({super.key, this.entity, this.isGridView});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Subtext(
        text: entity?.name,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(Icons.more_vert),
      leading: Image.network(
        'https://brands.home-assistant.io/${entity?.identifiers?[0][0]}/dark_icon.png',
        width: 50,
      ),
      subtitle:
          Subtext(text: '${entity?.manufacturer},SW: ${entity?.swVersion}'),
    );
  }
}

class CustomGridView extends StatelessWidget {
  final EntitiesModel? entity;
  final bool? isGridView;
  CustomGridView({super.key, this.entity, this.isGridView});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://brands.home-assistant.io/${entity?.identifiers?[0][0]}/dark_icon.png',
            height: 100,
          ),
          horizontalSpaceSmall,
          Subtext(
            text: entity?.name ?? '',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          )
        ],
      ),
    );
  }
}
