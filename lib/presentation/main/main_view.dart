import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_advanced/presentation/main/pages/notification/notification_page.dart';
import 'package:flutter_advanced/presentation/main/pages/search/view/search_page.dart';
import 'package:flutter_advanced/presentation/main/pages/setting/setting_page.dart';
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
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.setting.tr()
  ];

  // ignore: unused_field
  var _title = AppStrings.home.tr();
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
              spreadRadius: AppSize.s1_5,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorPallete.primaryOrange,
          unselectedItemColor: ColorPallete.gray,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.home.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: AppStrings.search.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppStrings.notification.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppStrings.setting.tr()),
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
