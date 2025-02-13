import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/main/pages/home_page.dart';
import 'package:flutter_advanced/presentation/main/pages/notification_page.dart';
import 'package:flutter_advanced/presentation/main/pages/search_page.dart';
import 'package:flutter_advanced/presentation/main/pages/setting_page.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

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

  final List<String> _titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.setting
  ];

  // ignore: unused_field
  var _title = AppStrings.home;
  // ignore: unused_field
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: AppSize.s5,
              spreadRadius: AppSize.s1,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorPallete.primaryOrange,
          unselectedItemColor: ColorPallete.gray,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppStrings.notification),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppStrings.setting),
          ],
          onTap: onTap,
        ),
      ),
    );
  }
  onTap (int index){
    setState(() {
      _currentIndex = index;
      _title = _titles[index];
    });
  }



}
