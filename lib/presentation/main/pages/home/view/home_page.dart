import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/domain/model/model.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/main/pages/home/viewmodel/home_view_model.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

import '../../../../resources/routes_manager.dart';

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
    return StreamBuilder<HomeViewObject>(
        stream: _homeViewModel.outputHomeData,
        builder: (context, snapshot) {
         return Column(
            children: [
              _getBannerCarousel(snapshot.data?.banners),
              _getSections(AppStrings.services),
              _getServices(snapshot.data?.services),
              _getSections(AppStrings.stores),
              _getStores(snapshot.data?.stores),
            ],
          );
        });
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

  Widget _getServices(List<Service>? services) {
    return StreamBuilder<List<Service>>(
        stream: _homeViewModel.outputHomeData.map((homeData) => homeData.services),
        builder: (context, snapshot) {
          return _getServicesWidget(snapshot.data);
        });
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services == null || services.isEmpty) {
      return const SizedBox();
    }
    return Container(
      height: AppSize.s180,
      margin: const EdgeInsets.all(AppMargin.m12),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(AppPadding.p2),
          child: Card(
            elevation: AppSize.s1_5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s14),
              side: BorderSide(
                  color: ColorPallete.primaryWhite, width: AppSize.s1_5),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  child: Image.network(
                    services[index].image,
                    fit: BoxFit.cover,
                    width: AppSize.s140,
                    height: AppSize.s140,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p2),
                  child: Text(
                    services[index].title,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getStores(List<Store>? stores) {
    return StreamBuilder<List<Store>>(
        stream: _homeViewModel.outputHomeData.map(
          (homeData) => homeData.stores,
        ),
        builder: (context, snapshot) {
          return _getStoresWidget(snapshot.data);
        });
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores == null || stores.isEmpty) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.all(AppMargin.m12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSize.s8,
          crossAxisSpacing: AppSize.s8,
          childAspectRatio: 1.1,
        ),
        itemCount: stores.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
          },
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
                stores[index].image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBannerCarousel(List<BannerAd>? banners) {
    return StreamBuilder<List<BannerAd>>(
        stream:
            _homeViewModel.outputHomeData.map((homeData) => homeData.banners),
        builder: (context, snapshot) {
          return _getBannerWidget(snapshot.data);
        });
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners == null || banners.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
    height: AppSize.s180,
    child: CarouselView.weighted(
      flexWeights: const [1, 7, 1], // This creates a hero layout with larger center item
      itemSnapping: true, // Enables snapping to items
      scrollDirection: Axis.horizontal,
      consumeMaxWeight: true,
      shrinkExtent: 0.0,
      onTap: (index) {
        setState(() {
        });
      },
      children: banners.map((banner) => 
        Card(
          elevation: AppSize.s1_5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s14),
            side: BorderSide(
              color: ColorPallete.primaryOrange,
              width: AppSize.s1_5
            ),
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
      ).toList(),
    ),
  );
  }
}
