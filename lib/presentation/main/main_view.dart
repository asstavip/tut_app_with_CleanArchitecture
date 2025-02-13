import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/main/pages/home_page.dart';
import 'package:flutter_advanced/presentation/main/pages/notification_page.dart';
import 'package:flutter_advanced/presentation/main/pages/search_page.dart';
import 'package:flutter_advanced/presentation/main/pages/setting_page.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  // ignore: unused_field
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingPage()
  ];

  // ignore: unused_field
  var _title = AppStrings.home;
  // ignore: unused_field
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(_title,style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: _pages[_currentIndex],
    );
  }
}
