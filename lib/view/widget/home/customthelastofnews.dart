import 'package:flutter/material.dart';
import 'package:news_api/core/constant/appcolor.dart';
import 'package:news_api/core/constant/dimensions_screen.dart';

class CustomTheLastOfNews extends StatelessWidget {
  const CustomTheLastOfNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: AppColor.primary,
          size: 60,
        ),
        SizedBox(
          height: heightScreen / 80,
        ),
        Text(
          "You're All Caught Up For Now",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
        )
      ],
    );
  }
}
