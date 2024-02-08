import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_api/core/constant/appcolor.dart';
import 'package:news_api/core/constant/dimensions_screen.dart';

class CustomCategoryImage extends StatelessWidget {
  final String image;
  final String title;
  const CustomCategoryImage(
      {Key? key, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      alignment: Alignment.center,
      width: widthScreen / 1.8,
      height: heightScreen / 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: AppColor.white, fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
