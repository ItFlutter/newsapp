import 'package:flutter/material.dart';

class CustomTitleAndSubtitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool? isBold;
  final bool? isUrl;
  final Color? colorText;
  final void Function()? onTapLink;
  const CustomTitleAndSubtitleText(
      {super.key,
      required this.text,
      required this.fontSize,
      this.isBold,
      this.isUrl,
      this.colorText,
      this.onTapLink});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isUrl == true ? onTapLink : null,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        // textAlign: TextAlign.start,
        style: TextStyle(
            color: colorText == null ? null : colorText,
            fontSize: fontSize,
            fontWeight: isBold == true ? FontWeight.w500 : null,
            decoration: isUrl == true ? TextDecoration.underline : null),
      ),
    );
  }
}
