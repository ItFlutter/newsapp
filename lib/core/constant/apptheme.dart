import 'package:flutter/material.dart';
import 'package:news_api/core/constant/appcolor.dart';

ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColor.transparent,
        titleTextStyle: TextStyle(
            color: AppColor.black, fontWeight: FontWeight.w500, fontSize: 20),
        elevation: 0.0));
