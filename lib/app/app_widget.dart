import 'package:cuidapet_fabreder/app/core/theme_cuidapet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Flutter Slidy',
      theme: ThemeCuidapet.theme(),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
