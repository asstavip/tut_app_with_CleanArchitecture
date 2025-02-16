import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/presentation/main/pages/home/viewmodel/home_view_model.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

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

  _bind(){
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
    return Center(child: Text(
      AppStrings.home
    ),);
  }
}

