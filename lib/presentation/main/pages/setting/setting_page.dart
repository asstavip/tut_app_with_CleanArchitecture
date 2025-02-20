import 'package:flutter/material.dart';
import 'package:flutter_advanced/data/data_source/local_data_source.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../resources/routes_manager.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: ListView(
          children: [
            ListTile(
              leading: SvgPicture.asset(ImageAssets.changeLanguageIc),
              title: Text(
                AppStrings.changeLanguage,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(ImageAssets.settingRightArrowIC),
              onTap: () {
                // ! TODO: change language
                _changeLanguage();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.contactUsIc),
              title: Text(
                AppStrings.contactUs,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(ImageAssets.settingRightArrowIC),
              onTap: () {
                // ! TODO: contact us
                _contactUs();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.inviteFriendIc),
              title: Text(
                AppStrings.inviteYourFreinds,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(ImageAssets.settingRightArrowIC),
              onTap: () {
                // ! TODO: invite friends
                _inviteFriend();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.logoutIc),
              title: Text(
                AppStrings.logout,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: SvgPicture.asset(ImageAssets.settingRightArrowIC),
              onTap: () {
                // ! TODO: logout
                _logout();
              },
            )
          ],
        ),
      ),
    );
  }


  void _changeLanguage() {
    // ? TODO: It will be implemented in the lessons of the next section
  }
  void _contactUs() {
    // ? TODO: A Task for me to implement to open any webPage using url
  }
  void _inviteFriend() {
    // ? TODO: A Task for me to implement to Share app name to friends
  }
  void _logout() {
    // navigate to login screen
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
    // app preferences make the use logged out
    _appPreferences.logout();
    // clear cache from data
    _localDataSource.clearCache();
  }
}
