import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/data/data_source/local_data_source.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/app_prefs.dart';
import '../../../../app/di.dart';
import '../../../resources/language_manager.dart';
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
                AppStrings.changeLanguage.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Transform(
                  transform: _isEnglishLanguage()
                      ? Matrix4.rotationY(0)
                      : Matrix4.rotationY(math.pi),
                  child: SvgPicture.asset(ImageAssets.settingRightArrowIC)),
              onTap: () {
                // ! TODO: change language
                _changeLanguage();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.contactUsIc),
              title: Text(
                AppStrings.contactUs.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Transform(
                transform: _isEnglishLanguage()
                    ? Matrix4.rotationY(0)
                    : Matrix4.rotationY(math.pi),
                child: SvgPicture.asset(ImageAssets.settingRightArrowIC),
              ),
              onTap: () {
                // ! TODO: contact us
                _contactUs();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.inviteFriendIc),
              title: Text(
                AppStrings.inviteYourFreinds.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Transform(transform: _isEnglishLanguage()
                  ? Matrix4.rotationY(0)
                  : Matrix4.rotationY(math.pi),
              child: SvgPicture.asset(ImageAssets.settingRightArrowIC)),
              onTap: () {
                // ! TODO: invite friends
                _inviteFriend();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.logoutIc),
              title: Text(
                AppStrings.logout.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: Transform(transform: _isEnglishLanguage()
                  ? Matrix4.rotationY(0)
                  : Matrix4.rotationY(math.pi),
              child: SvgPicture.asset(ImageAssets.settingRightArrowIC)),
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

  void _changeLanguage() async {
    // ? TODO: It will be implemented in the lessons of the next section
    await _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }

  bool _isEnglishLanguage() => context.locale.languageCode == LanguageType.ENGLISH.getValue();

  void _contactUs() async {
    // Define your contact URL (e.g., your website or a mailto link)
    final Uri contactUrl = Uri.parse("https://flutter.dev");

    // Check if the device can handle the URL
    if (await canLaunchUrl(contactUrl)) {
      // Launch the URL in the browser or the appropriate app
      await launchUrl(contactUrl, mode: LaunchMode.externalApplication);
    } else {
      // Optionally, show an error message if the URL cannot be launched
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open the contact page")),
      );
    }
  }

  void _inviteFriend() {
    String appName = "Tut App"; // Replace with your app name
    String appLink =
        "https://play.google.com/store/apps/details?id=com.example.tut_app";
    String shareText = "${AppStrings.checkOutApp.tr()} $appName!\n\n$appLink";
    Share.share(shareText);
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
