import 'package:flutter/material.dart';
import 'package:iot_app/ui/views/home/home_viewmodel.dart';
import 'package:iot_app/ui/widget/title_widget.dart';
import 'package:iot_app/ui/widgets/common/custom_appbar/custom_appbar.dart';
import 'package:iot_app/ui/widgets/common/subtext/subtext.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, chile) => Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            CustomAppbar(
              title: viewModel.companyInfoModel?.companyName,
              leading: IconButton(
                highlightColor: Colors.amber,
                onPressed: model.showBottomSheet,
                icon: const Icon(
                  Icons.person_2_rounded,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: viewModel.showDialog,
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.primary,
                    ))
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  height: 140.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 160.0,
                        child: Card(
                          elevation: 0.0,
                          color: Theme.of(context).colorScheme.primary,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Subtext(
                                    text: translate(context).ksConnectedDevice,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TitleWidget(
                                  title:
                                      viewModel.data?.length.toString() ?? '',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: viewModel.showDialog,
                        child: SizedBox(
                          width: 160.0,
                          child: Card(
                            elevation: 0.0,
                            color: Theme.of(context).colorScheme.primary,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Subtext(
                                    text: translate(context).ksThirdPartyDevice,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TitleWidget(
                                    title: viewModel
                                        .websocketProvider.entities.length
                                        .toString(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 60,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160.0,
                        child: Card(
                          elevation: 0.0,
                          color: Theme.of(context).colorScheme.primary,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Subtext(
                                  text: translate(context).ksThirdPartyDevice,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TitleWidget(
                                  title: '0',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                  padding: const EdgeInsets.all(15),
                  child:
                      TitleWidget(title: translate(context).ksDeviceAllArea)),
            ),
            if (viewModel.dataReady) ...[
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 160,
                      width: 160.0,
                      child: Card(
                        elevation: 0.0,
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Badge(
                          smallSize: 25,
                          backgroundColor:
                              viewModel.data?[index].isActive ?? false
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.error,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Subtext(
                                  text: 'Name: ${viewModel.data?[index].name}',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Subtext(
                                  text:
                                      'Location: ${viewModel.data?[index].lineName}-${viewModel.data?[index].stationId}',
                                ),
                                Image.network(
                                  'https://shop.m5stack.com/cdn/shop/products/01_1200x1200.jpg?v=1587104211',
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: viewModel.data?.length ?? 0,
                ),
              ),
            ] else ...[
              const SliverToBoxAdapter(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Subtext(
                        text:
                            'Cannot optain data, please check with administrator'),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.initialize();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
