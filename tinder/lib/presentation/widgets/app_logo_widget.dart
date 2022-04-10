import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/index.dart';

class AppLogoWidget extends StatelessWidget {
  final double width;
  final double height;

  const AppLogoWidget({
    this.width = 120,
    this.height = 120,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: width,
          height: height,
          child: SvgPicture.asset(AppImages.icAppLogo)),
    );
  }
}
