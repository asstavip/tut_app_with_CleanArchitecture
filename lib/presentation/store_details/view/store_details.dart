import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:flutter_advanced/presentation/store_details/viewmodel/store_details_view_model.dart';

import '../../../domain/model/model.dart';
import '../../resources/strings_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _storeDetailsViewModel =
      instance<StoreDetailsViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _storeDetailsViewModel.dispose();
    super.dispose();
  }

  _bind() {
    _storeDetailsViewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.storeDetails,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: _storeDetailsViewModel.outputState,
              builder: (context, snapshot) =>
                  snapshot.data?.getScreenWidget(context, _getContentWidget(),
                      () {
                    _storeDetailsViewModel.start();
                  }) ??
                  _getContentWidget()),
        ),
      ),
    );
  }

  _getContentWidget() {
    return StreamBuilder<StoreDetails>(
        stream: _storeDetailsViewModel.outputStoreDetails,
        builder: (context, snapshot) {
          return Column(
            spacing: AppSize.s12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Store Image
              Padding(
                padding: const EdgeInsets.all(AppSize.s12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  child: Image.network(
                    snapshot.data?.image ?? "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: AppSize.s180,
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
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(
                  snapshot.data?.title ?? "",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(
                  snapshot.data?.details ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              // Services
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(
                  AppStrings.services,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Text(
                  snapshot.data?.services ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              // About
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                child: Text(
                  AppStrings.about,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Text(
                  snapshot.data?.about ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          );
        });
  }
}
