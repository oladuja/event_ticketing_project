import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/helpers/extensions.dart';
import '../helpers/app_dimensions.dart';
import 'app_icon_button.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.targetPlatform,
    this.child,
    this.showAppBar = true,
    this.appBar,
    this.appBarActions,
    this.appBarBottom,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.scaffoldKey,
    this.onBackPressed, this.leading, this.iosNavigationBar, this.previousPageTitle, this.appBarTitle,
    this.useGestureDetector = true, this.leadingAppBarWidth,
  });

  const AppScaffold.android({
    super.key,
    this.targetPlatform = TargetPlatform.android,
    this.child,
    this.showAppBar = true,
    this.appBar,
    this.appBarActions,
    this.appBarBottom,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.scaffoldKey,
    this.onBackPressed, this.leading, this.iosNavigationBar, this.previousPageTitle, this.appBarTitle,
    this.useGestureDetector = true, this.leadingAppBarWidth,
  });

  const AppScaffold.ios({
    super.key,
    this.targetPlatform = TargetPlatform.iOS,
    this.child,
    this.showAppBar = true,
    this.appBar,
    this.appBarBottom,
    this.appBarActions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.scaffoldKey,
    this.onBackPressed, this.leading, this.iosNavigationBar, this.previousPageTitle, this.appBarTitle,
    this.useGestureDetector = true, this.leadingAppBarWidth,
  });

  final TargetPlatform? targetPlatform;
  final bool showAppBar;
  final Widget? leading;
  final PreferredSizeWidget? appBar;
  final PreferredSizeWidget? appBarBottom;
  final ObstructingPreferredSizeWidget? iosNavigationBar;
  final List<Widget>? appBarActions;

  final String? previousPageTitle;
  final Widget? appBarTitle;
  final double? leadingAppBarWidth;

  final Widget? child;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Function? onBackPressed;
  final bool useGestureDetector;

  @override
  Widget build(BuildContext context) {
    if(!useGestureDetector){
      return getBody(context);
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onHorizontalDragStart: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragStart: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: getBody(context),
    );
  }

  Widget getBody(BuildContext context){
    return Material(
      key: key,
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: systemOverlayStyle ?? SystemUiOverlayStyle(
            statusBarColor: context.colorScheme.surface,
            statusBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: context.colorScheme.surface,
        ),
        child: Scaffold(
          key: scaffoldKey,
          appBar: showAppBar ? (appBar ?? AppBar(
            leading: leading ?? Builder(
                builder: (context) {
                  if(!Navigator.canPop(context)){
                    return const SizedBox.shrink();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.heightBox,
                      AppIconButton(
                        icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back_ios,
                        margin: const EdgeInsets.only(left: AppDimensions.horizontalPadding , top: 0, bottom: 0,right: AppDimensions.horizontalPadding - 2),
                        backgroundColor: Colors.transparent,
                        iconColor: context.colorScheme.primary.withOpacity(0.7),
                        onPressed: () {
                          if(onBackPressed != null){
                            FocusManager.instance.primaryFocus?.unfocus();
                            onBackPressed!();
                          }else{
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.navigateBack();
                          }
                        },
                      ),
                    ],
                  );
                }
            ),
            leadingWidth: leadingAppBarWidth,
            automaticallyImplyLeading: false,
            title: appBarTitle ?? Text(
              '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            actions: appBarActions,
            backgroundColor: Colors.transparent,
            bottom: appBarBottom,
            systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle(
              statusBarColor: context.colorScheme.surface,
              statusBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
              systemNavigationBarIconBrightness: context.isDarkMode ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: context.colorScheme.surface,
            ),
          )) : null,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          backgroundColor: Colors.transparent,
          body: child,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}