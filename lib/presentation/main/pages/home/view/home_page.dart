import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/main/pages/home/viewmodel/home_view_model.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  _bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  final HomeViewModel _homeViewModel = instance<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder(
            stream: _homeViewModel.outputState,
            builder: (context, snapshot) =>
                snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _homeViewModel.start();
                }) ??
                _getContentWidget()),
      ),
    );
  }

  _getContentWidget() {
    return Column(
      children: [
        _getBannerCarousel(),
        _getSections(AppStrings.services),
        _getServicesWidget(),
        _getSections(AppStrings.stores),
        _getStoresWidget(),
      ],
    );
  }



  Widget _getSections(String title) {
    return Padding(padding:  EdgeInsets.all(AppPadding.p12), child: Text(title,style: Theme.of(context).textTheme.displaySmall,),);
  }

  Widget _getServicesWidget() {
    return Container();
  }

  Widget _getStoresWidget() {
    return Container();
  }

  Widget _getBannerCarousel() {
    return Container();
  }
}
