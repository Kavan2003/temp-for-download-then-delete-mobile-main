import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double height;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;

  AppText({
    Key? key,
    required this.text,
    this.color,
    required this.height,
    required this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontSize: Get.height * height,
        color: color,
        overflow: TextOverflow.clip,
        fontStyle: fontStyle,
      ),
    );
  }
}
