import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(
      AppStrings.notification
    ),);
  }
}