import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

enum ScreenSize { small, medium, large }
const _breakpoint1 = 600.0;
const _breakpoint2 = 840.0;

extension WidgetExtension on Widget {
  Widget withSafeArea({
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
  }){
    if(kIsWeb){
      return this;
    }
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: this,
    );
  }

  Widget onClick(Function() onTap,{
    double borderRadius = 0,
    String? toolTip,
    Key? key,
    bool allowClick = true,
  }){
    if(allowClick == false){
      return this;
    }
    if(toolTip == null){
      return Material(
        key: key,
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: this,
        ),
      );
    }
    return Material(
      key: key,
      type: MaterialType.transparency,
      child: Tooltip(
        message: toolTip,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: this,
        ),
      ),
    );
  }

  Widget withBorderRadius({
    double radius = 0,
  }){
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  Widget withBorder({
    Color color = Colors.transparent,
    double width = 0,
    double radius = 0,
  }){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: color,
              width: width
          ),
          borderRadius: BorderRadius.circular(radius)
      ),
      child: this,
    );
  }

  Widget withHero({
    required String tag,
  }){
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: this,
      ),
    );
  }

  Widget withPadding({
    double top = 0,
    double bottom = 0,
    double left = 0,
    double right = 0,
  }){
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: this,
    );
  }

  Widget withPaddingAll(double padding){
    return Padding(
      padding: padding.allPadding,
      child: this,
    );
  }

}
extension BuildContextExtension on BuildContext{
  /// Returns the screen size based on the width of the screen
  /// [ScreenSize.small] if width < 600
  /// [ScreenSize.medium] if width >= 600 && width <= 840
  /// [ScreenSize.large] if width > 840
  /// This is an extension on [BuildContext] so it can be called from anywhere a [BuildContext] is available
  /// Example:
  /// ```
  /// final screenSize = context.screenSize;
  /// ```
  /// Also, you can check if the screen is small, medium or large using the following:
  /// ```
  /// final isSmall = context.isSmall;
  /// final isMedium = context.isMedium;
  /// final isLarge = context.isLarge;
  ScreenSize get screenSize {
    if (kDebugMode) print('size.width = $width');
    if (width < _breakpoint1) {
      if(kDebugMode) print('ScreenSize = small');
      return ScreenSize.small;
    }
    else if (width >= _breakpoint1 && width <= _breakpoint2) {
      if(kDebugMode) print('ScreenSize = medium');
      return ScreenSize.medium;
    }
    else {
      if(kDebugMode) print('ScreenSize = large');
      return ScreenSize.large;
    }
  }
  bool get isSmall => screenSize == ScreenSize.small;
  bool get isMedium => screenSize == ScreenSize.medium;
  bool get isLarge => screenSize == ScreenSize.large;

  ColorScheme get colorScheme{
    return Theme.of(this).colorScheme;
  }
  TextTheme get textTheme{
    return Theme.of(this).textTheme;
  }
  Color get transparent{
    return Colors.transparent;
  }
  TargetPlatform get platform{
    //return TargetPlatform.iOS;
    return Theme.of(this).platform;
  }

  bool get isDarkMode{
    return Theme.of(this).brightness == Brightness.dark;
  }

  Brightness get brightness{
    return isDarkMode ? Brightness.light : Brightness.dark;
  }

  num get width{
    return MediaQuery.sizeOf(this).width;
  }
  num get height{
    return MediaQuery.sizeOf(this).height;
  }
}
extension FileExtension on File?{
  String get formattedSize{
    if(this == null) return '';
    final bytes = this!.lengthSync();
    if(bytes <= 0) return '0 B';
    final kb = bytes / 1024;
    if(kb < 1) return '${bytes.toStringAsFixed(2)} B';
    final mb = kb / 1024;
    if(mb < 1) return '${kb.toStringAsFixed(2)} KB';
    final gb = mb / 1024;
    if(gb < 1) return '${mb.toStringAsFixed(2)} MB';
    final tb = gb / 1024;
    if(tb < 1) return '${gb.toStringAsFixed(2)} GB';
    return '${tb.toStringAsFixed(2)} TB';
  }

  String get shortName{
    if(this == null) return '';
    return this!.path.getShortNameFromFilePathOrUrl;
  }
}
extension ColorExtension on Color{
  calculateLuminance(){
    final luminance = (0.2126 * red + 0.7152 * green + 0.0722 * blue) / 255;
    return luminance;
  }

  String toHex() => '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';

  bool get isDark {
    return ThemeData.estimateBrightnessForColor(this) == Brightness.dark;
  }

  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(alpha, red + ((255 - red) * p).round(), green + ((255 - green) * p).round(), blue + ((255 - blue) * p).round());
  }
}
extension NumExtension on num{
  EdgeInsets get topPadding {
    return EdgeInsets.only(top: toDouble());
  }

  EdgeInsets get bottomPadding {
    return EdgeInsets.only(bottom: toDouble());
  }

  EdgeInsets get leftPadding {
    return EdgeInsets.only(left: toDouble());
  }

  EdgeInsets get rightPadding {
    return EdgeInsets.only(right: toDouble());
  }

  EdgeInsets get rightAndLeftPadding {
    return EdgeInsets.only(right: toDouble(), left: toDouble());
  }

  EdgeInsets get rightAndTopPadding {
    return EdgeInsets.only(right: toDouble(), top: toDouble());
  }

  EdgeInsets get rightAndBottomPadding {
    return EdgeInsets.only(right: toDouble(), bottom: toDouble());
  }

  EdgeInsets get leftAndTopPadding {
    return EdgeInsets.only(left: toDouble(), top: toDouble());
  }

  EdgeInsets get leftAndBottomPadding {
    return EdgeInsets.only(left: toDouble(), bottom: toDouble());
  }

  EdgeInsets get horizontalPadding {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  EdgeInsets get verticalPadding {
    return EdgeInsets.symmetric(vertical: toDouble());
  }

  EdgeInsets get allPadding {
    return EdgeInsets.all(toDouble());
  }

  EdgeInsetsDirectional get startPadding {
    return EdgeInsetsDirectional.only(start: toDouble());
  }

  EdgeInsetsDirectional get endPadding {
    return EdgeInsetsDirectional.only(end: toDouble());
  }

  EdgeInsetsDirectional get topStartPadding {
    return EdgeInsetsDirectional.only(top: toDouble(), start: toDouble());
  }

  EdgeInsetsDirectional get topEndPadding {
    return EdgeInsetsDirectional.only(top: toDouble(), end: toDouble());
  }

  EdgeInsetsDirectional get bottomStartPadding {
    return EdgeInsetsDirectional.only(bottom: toDouble(), start: toDouble());
  }

  EdgeInsetsDirectional get bottomEndPadding {
    return EdgeInsetsDirectional.only(bottom: toDouble(), end: toDouble());
  }

  EdgeInsetsDirectional get startAndEndPadding {
    return EdgeInsetsDirectional.only(start: toDouble(), end: toDouble());
  }

  BorderRadius get allRadius {
    return BorderRadius.circular(toDouble());
  }

  BorderRadius get topLeftRadius {
    return BorderRadius.only(topLeft: Radius.circular(toDouble()));
  }

  BorderRadius get topRightRadius {
    return BorderRadius.only(topRight: Radius.circular(toDouble()));
  }

  BorderRadius get bottomLeftRadius {
    return BorderRadius.only(bottomLeft: Radius.circular(toDouble()));
  }

  BorderRadius get bottomRightRadius {
    return BorderRadius.only(bottomRight: Radius.circular(toDouble()));
  }

  Duration get millisecondsDuration {
    return Duration(milliseconds: toInt());
  }

  Duration get secondsDuration {
    return Duration(seconds: toInt());
  }

  Duration get minutesDuration {
    return Duration(minutes: toInt());
  }

  Duration get hoursDuration {
    return Duration(hours: toInt());
  }

  Duration get daysDuration {
    return Duration(days: toInt());
  }

  Duration get weeksDuration {
    return Duration(days: toInt() * 7);
  }

  Duration get monthsDuration {
    return Duration(days: toInt() * 30);
  }

  Duration get yearsDuration {
    return Duration(days: toInt() * 365);
  }

  SizedBox get heightBox {
    return SizedBox(height: toDouble());
  }

  SizedBox get widthBox {
    return SizedBox(width: toDouble());
  }

  String get timeInString{
    final seconds = this ~/ 1000;
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    final hoursString = hours.toString().padLeft(2, '0');
    if(hoursString == '00'){
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    return '$hoursString:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String get approximate{

    if(this < 1000){
      return this.toInt().toString();
    }
    if(this < 1000000){
      if(this % 1000 == 0){
        return '${(this/1000).toInt()}k';
      }
      return '${(this/1000).toStringAsFixed(1)}k';
    }
    if(this < 1000000000){
      if(this % 1000000 == 0){
        return '${(this/1000000).toInt()}m';
      }
      return '${(this/1000000).toStringAsFixed(1)}m';
    }
    if(this % 1000000000 == 0){
      return '${(this/1000000000).toInt()}b';
    }
    return '${(this/1000000000).toStringAsFixed(1)}b';

  }
  
  String get approximation{
    if(this < 1000){
      return this.toInt().toString();
    }
    if(this < 1000000){
      if(this % 1000 == 0){
        return '${(this/1000).toInt()} thousand';
      }
      return '${(this/1000).toStringAsFixed(1)} thousand';
    }
    if(this < 1000000000){
      if(this % 1000000 == 0){
        return '${(this/1000000).toInt()} million';
      }
      return '${(this/1000000).toStringAsFixed(1)} million';
    }
    if(this % 1000000000 == 0){
      return '${(this/1000000000).toInt()} billion';
    }
    return '${(this/1000000000).toStringAsFixed(1)} billion';

  }

  double get responsiveText{
    return sp;
  }
  double get responsiveHeight{
    return h;
  }double get responsiveWidth{
    return w;
  }
}
extension StringExtension on String{
  String currency({String? symbol}) {

    int step = 1;
    String val = this;

    for (var i = val.length-1; i >=0; i--) {
      if (i - 2*step > 0) {

        val = val.replaceRange(i-2*step, i-2*step, ",");
        step++;
      }
    }

    if(symbol == null){
      return val;
    }
    return "$symbol$val";
  }
  String get getShortNameFromFilePathOrUrl{
    //Todo:: Make this more accurate with regex
    if(startsWith('http') || startsWith('https')){
      try{
        final uri = Uri.parse(this);
        return uri.host;
      }catch(_){
        return this;
      }
    }else{
      return split('/').last;
    }
  }
  String get getShortNameFromFileWithoutExtension{
    return split('/').last.split('.').first;
  }
  String get getFileExtension{
    try{
      return split('.').last;
    }catch(_){
      return '';
    }
  }
  SnackbarController showMessage({
    String? title,
    SnackPosition snackPosition = SnackPosition.TOP,
    Duration duration = const Duration(milliseconds: 3000),
    Color backgroundColor = const Color(0xFF289B4F),
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    double borderRadius = 5,
  }){
    return Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: this,
        snackPosition: snackPosition,
        duration: duration,
        backgroundColor: backgroundColor,
        padding: padding,
        borderRadius: borderRadius,
      ),
    );
  }

  SnackbarController showErrorMessage({
    String? title,
    SnackPosition snackPosition = SnackPosition.TOP,
    Duration duration = const Duration(milliseconds: 3000),
    Color? backgroundColor,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    double borderRadius = 5,
  }){
    return Get.showSnackbar(
      GetSnackBar(
        title: title,
        message: this,
        snackPosition: snackPosition,
        duration: duration,
        backgroundColor: backgroundColor ?? Colors.red,
        padding: padding,
        borderRadius: borderRadius,
      ),
    );
  }
}
extension EdgeInsetsDirectionalExtension on EdgeInsetsDirectional{
  EdgeInsetsDirectional copyWith({
    double? start,
    double? end,
    double? top,
    double? bottom,
  }){
    return EdgeInsetsDirectional.only(
      start: start ?? this.start,
      end: end ?? this.end,
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
    );
  }
}
extension DateTimeExtension on DateTime{
  String timeAgo(){
    return timeago.format(this);
  }
}
extension NavigationExtension on BuildContext{
  Future<void> navigateTo(Widget page) async {
    await Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
  }
  Future<void> navigateToAndRemoveUntil(Widget page) async {
    await Navigator.of(this).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (route) => false);
  }
  Future<void> navigateToAndReplace(Widget page) async {
    await Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (context) => page));
  }
  Future<void> navigateToAndReplaceUntil(Widget page) async {
    await Navigator.of(this).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => page), (route) => false);
  }
  void navigateBack(){
    Navigator.of(this).pop();
  }
  void navigateBackWithData(dynamic data){
    Navigator.of(this).pop(data);
  }
  bool canNavigateBack(){
    return Navigator.of(this).canPop();
  }
}
extension DialogExtension on BuildContext{
  Future<void> showAlertDialog({
    required String title,
    required String message,
    String? positiveButton,
    String? negativeButton,
    Function()? onPositivePressed,
    Function()? onNegativePressed,
  }) async {
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if(negativeButton != null)...[
            TextButton(
              onPressed: onNegativePressed ?? () => Navigator.of(context).pop(),
              child: Text(negativeButton),
            ),
          ],
          TextButton(
            onPressed: onPositivePressed ?? () => Navigator.of(context).pop(),
            child: Text(positiveButton ?? 'OK'),
          ),
        ],
      ),
    );
  }

  Future<void> showConfirmationDialog({
    required String title,
    required String message,
    String? positiveButton,
    String? negativeButton,
    Function()? onPositivePressed,
    Function()? onNegativePressed,
  }) async {
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if(negativeButton != null)...[
            TextButton(
              onPressed: onNegativePressed ?? () => Navigator.of(context).pop(),
              child: Text(negativeButton),
            ),
          ],
          TextButton(
            onPressed: onPositivePressed ?? () => Navigator.of(context).pop(),
            child: Text(positiveButton ?? 'OK'),
          ),
        ],
      ),
    );
  }

  Future<void> showCustomDialog({
    required Widget content,
  }) async {
    return showDialog(
      context: this,
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
