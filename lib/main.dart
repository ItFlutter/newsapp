import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:news_api/bindings/initialbindings.dart';
import 'package:news_api/routes.dart';
import 'package:news_api/view/screen/home.dart';

import 'core/constant/apptheme.dart';

void main() {
  print(
      "=================================main=================================");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "=================================My_App=================================");
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            initialBinding: InitialBindings(),
            debugShowCheckedModeBanner: false,
            title: 'News',
            theme: appTheme,
            getPages: routes,
            home: const HomePage(),
          );
        });
  }
}
