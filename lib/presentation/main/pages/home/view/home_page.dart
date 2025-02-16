import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/main/pages/home/viewmodel/home_view_model.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';
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
        _getServices(),
        _getSections(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getSections(String title) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _getServices() {
    return StreamBuilder<List<Service>>(
        stream: _homeViewModel.outputService,
        builder: (context, snapshot) {
          return _getServicesWidget(snapshot.data);
        });
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services == null || services.isEmpty) {
      return const SizedBox();
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child:Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    side: BorderSide(
                        color: ColorPallete.primaryOrange, width: AppSize.s1_5),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    child: Image.network(
                      services[index].image,
                      fit: BoxFit.cover,
                      width: AppSize.s100,
                      height: AppSize.s100,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(AppPadding.p8),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      services[index].title,
                      style: Theme.of(context).textTheme.displaySmall,),
                  ),
                  )
                    ],
                  )
                ),
      ),
    );
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
        stream: _homeViewModel.outputStore,
        builder: (context, snapshot) {
          return _getStoresWidget(snapshot.data);
        });
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores == null || stores.isEmpty) {
      return const SizedBox();
    }
    return Container(
      height: AppSize.s140,
      margin: const EdgeInsets.all(AppMargin.m12),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stores.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(stores[index].title),
        ),
      ),
    );
  }

  Widget _getBannerCarousel() {
    return StreamBuilder<List<BannerAd>>(
        stream: _homeViewModel.outputBannerAd,
        builder: (context, snapshot) {
          return _getBannerWidget(snapshot.data);
        });
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners == null || banners.isEmpty) {
      return const SizedBox();
    }
    return CarouselSlider(
      items: banners
          .map((banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    side: BorderSide(
                        color: ColorPallete.primaryOrange, width: AppSize.s1_5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: AppSize.s150,
        autoPlay: true,
        enlargeCenterPage: true,
        enlargeFactor: AppSize.s0_3,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
