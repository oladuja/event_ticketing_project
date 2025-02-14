import 'package:flutter/material.dart';

class AppIcons {
  /// Define local assets
  static const String emptyPage = 'assets/images/empty_page.svg';
  static const String emptyPageLight = 'assets/images/empty_page_light.svg';
  static const String emptyPageDark = 'assets/images/empty_page_dark.svg';
  static const String comments = 'assets/images/comments.svg';
  static const String users = 'assets/images/users.svg';
  static const String welcome = 'assets/images/welcome.svg';

  static const double sizeSmall = 22;
  static const double sizeMedium = 35;
  static const double sizeLarge = 50;

  /// Check if the icon is SVG
  static bool isSvg(String path) => path.contains('svg');

  static bool isPng(String path) => path.contains('png');

  static bool isJpg(String path) => path.contains('jpg') || path.contains('jpeg');

  /// Return the icon accordingly
  static Widget icon(String path, {
    double width = sizeSmall,
    double height = sizeSmall,
    Color? color,
    BoxFit? fit ,
  }) {
    if (isSvg(path)) {
      throw UnimplementedError();
      // return SvgPicture.asset(
      //   path,
      //   width: width,
      //   height: height,
      //   fit: fit ?? BoxFit.contain,
      //   colorFilter: color == null ? null : ColorFilter.mode(
      //     color,
      //     BlendMode.srcIn,
      //   ),
      // );
    } else {
      if(color == null){
        return Image.asset(
          path,
          width: width,
          height: height,
          fit: fit,
        );
      }else{
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            path,
            width: width,
            height: height,
            fit: fit,
          ),
        );
      }
    }
  }
}
