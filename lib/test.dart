import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/app.dart';

class Test extends StatelessWidget {

  const Test({super.key});

  void updateAppState() {
    MyApp.instance.counter = 10;
  }
  void getAppState() {
    print(MyApp.instance.counter);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
