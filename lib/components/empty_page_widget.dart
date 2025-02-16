import 'package:flutter/material.dart';
import 'package:project/helpers/extensions.dart';



import '../helpers/app_icons.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget({
    super.key, this.imagePath, this.title, this.iconData,
  });
  final String? imagePath;
  final IconData? iconData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    if(iconData != null && imagePath != null){
      throw Exception('Only one of iconData or imagePath can be provided');
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(imagePath != null && iconData == null)...[
            AppIcons.icon(
              imagePath ?? AppIcons.emptyPageLight,
              width: context.width * 0.3,
              height: context.width * 0.3,
            ),
          ],
          if(iconData != null && imagePath == null)...[
            Icon(
              iconData,
              size: 150,
              color: context.colorScheme.onSurface.withOpacity(.5),
            ),
          ],
          const SizedBox(height: 20),
          Text(
            title ?? 'nothing_here',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.responsiveText,
              color: context.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}