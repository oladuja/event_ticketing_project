import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:project/helpers/extensions.dart';


class AppAvatar extends StatefulWidget {
  const AppAvatar({
    super.key,
    this.imgUrl = '',
    this.radius = 360,
    this.width = 100,
    this.height = 100,
    this.borderWidth = 1,
    this.backgroundColor = Colors.grey,
    this.borderColor,
    this.bytes,
    this.isContact = false,
    this.contactName = '',
    this.imagePlaceholder,
    this.imageFile,
    this.useCachedImage = true,
    this.useTextPlaceholder = false,
    this.useImagePlaceholder = false,
  });

  final String imgUrl;
  final double radius;
  final double? width;
  final double? height;
  final double borderWidth;
  final Color backgroundColor;
  final Color? borderColor;
  final Uint8List? bytes;
  final File? imageFile;
  final bool isContact;
  final String contactName;
  final Widget? imagePlaceholder;
  final bool useCachedImage;
  final bool useTextPlaceholder;
  final bool useImagePlaceholder;

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  bool useCachedImage = true;

  @override
  void initState() {
    super.initState();
    useCachedImage = widget.useCachedImage;
    if(!useCachedImage){
      CachedNetworkImage.evictFromCache(widget.imgUrl).then((value) {
        if(mounted){
          setState(() {});
        }
      });
    }
  }

  Widget _textPlaceholder(){
    var nameToDisplay = '';
    if(widget.contactName.split(' ').length >= 2){
      final names = widget.contactName.split(' ');
      nameToDisplay = names[0][0] + names[1][0];
    }else if(widget.contactName.length > 1){
      final names = widget.contactName.split(' ');
      if(names.length > 1){
        nameToDisplay = names[0][0] + names[1][0];
      }else{
        nameToDisplay = names[0][0];
      }
    }else if(widget.contactName.isNotEmpty){
      nameToDisplay = widget.contactName[0];
    }
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Builder(
            builder: (context) => Center(
              child: Text(
                nameToDisplay,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imagePlaceholder(){
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Builder(
            builder: (context) => widget.imagePlaceholder ?? Icon(
              Iconsax.profile_circle,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholder(){
    if(widget.useTextPlaceholder){
      return _textPlaceholder();
    }else if(widget.useImagePlaceholder){
      return _imagePlaceholder();
    }else {
      return const SizedBox.shrink();
    }
  }

  Widget _svgImage(String url) {
    return SvgPicture.network(
      url,
      width: widget.width,
      height: widget.height,
      placeholderBuilder: (context) => _placeholder(),
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if(widget.bytes != null){
      child = Image.memory(
        widget.bytes!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }else if(widget.imageFile != null){
      child = Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }else if(widget.imgUrl == 'null' || widget.imgUrl.trim().isEmpty){
      child = _placeholder();
    }else if (widget.imgUrl.endsWith('.svg')) {
      child = _svgImage(widget.imgUrl);
    }else{
      child = CachedNetworkImage(
        imageUrl: widget.imgUrl,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => _placeholder(),
        placeholder: (context, url) => _placeholder(),
        width: widget.width,
        height: widget.height,
      );
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: Border.all(
            color: widget.borderColor ?? context.colorScheme.surface,
            width: widget.borderWidth,
          ),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: SizedBox.expand(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: child,
          ),
        ),
      ),
    );

    if(widget.bytes != null){
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Image.memory(
            widget.bytes!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _placeholder(),
          ),
        ),
      );
    }
    if(widget.imageFile != null){
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: Image.file(
            widget.imageFile!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _placeholder(),
          ),
        ),
      );
    }
    if(widget.imgUrl == 'null' || widget.imgUrl.isEmpty){
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        child: SizedBox.expand(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: Builder(
                builder: (context) => _placeholder(),
            ),
          ),
        ),
      );
    }
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.radius),
      ),
      child: SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: CachedNetworkImage(
            imageUrl: widget.imgUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => _placeholder(),
            placeholder: (context, url) => _placeholder(),
            width: widget.width,
            height: widget.height,
          ),
        ),
      ),
    );
  }
}
