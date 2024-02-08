import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/core/constant/dimensions_screen.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String image;
  final double? heightImage;
  const CustomCachedNetworkImage(
      {super.key, required this.image, this.heightImage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        height: heightImage == null ? heightScreen / 4 : heightImage,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
