import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studhad/helpers/extensions.dart';


import 'app_textfields.dart';

class AppDropdownMenuEntry<T> {
  const AppDropdownMenuEntry({
    required this.value,
    this.searchValue = '',
    this.labelWidget,
    this.leadingWidget,
    this.trailingWidget,
    this.selectedLeadingWidget,
    this.selectedTrailingWidget,
  });
  
  final T value;

  final String searchValue;
  
  final Widget? labelWidget;

  final Widget? leadingWidget;

  final Widget? trailingWidget;

  final Widget? selectedLeadingWidget;

  final Widget? selectedTrailingWidget;
}

typedef AppDropDownValueBuilder<T> = List<AppDropdownMenuEntry<T>> Function();

class AppDropDownTextField<T> extends StatefulWidget {
  const AppDropDownTextField({
    required this.itemBuilder,
    super.key,
    this.controller,
    this.initialSelection,
    this.height,
    this.width,
    this.dropDownWidth,
    this.enableSearch = true,
    this.showMenu = true,
    this.onItemSelected,
    this.onMenuStateChanged,
    this.hint,
    this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.menuBackgroundColor,
    this.enabled = true,
    this.menuItemPadding,
    this.contentPadding,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController? controller;
  final T? initialSelection;
  final Function(T?)? onItemSelected;
  final Function(bool)? onMenuStateChanged;
  final AppDropDownValueBuilder<T> itemBuilder;
  final double? height;
  final double? width;
  final double? dropDownWidth;
  final bool enabled;
  final bool enableSearch;
  final bool showMenu;
  final String? hint;
  final String? label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? menuBackgroundColor;
  final EdgeInsets? menuItemPadding;
  final EdgeInsets? contentPadding;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppDropDownTextField<T>> createState() => _AppDropDownTextFieldState<T>();
}
class _AppDropDownTextFieldState<T> extends State<AppDropDownTextField<T>> {
  final FocusNode _focusNode = FocusNode();
  ValueNotifier<bool> isMenuOpen = ValueNotifier(false);
  TextEditingController _controller = TextEditingController();
  final GlobalKey _globalKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  @override
  void initState(){
    super.initState();
    if(widget.controller != null){
      _controller = widget.controller!;
    }
  }

  Future<void> _showOverlay(BuildContext context) async{
    final renderBox = _globalKey.currentContext!.findRenderObject()! as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) => Positioned(
      top: position.dy + renderBox.size.height + 5,
      left: position.dx,
      width: widget.dropDownWidth ?? renderBox.size.width,
      child: CompositedTransformFollower(
        offset: Offset(0, renderBox.size.height + 5),
        link: _layerLink,
        child: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context,value,child) {
              final filteredItems = !widget.enableSearch ? widget.itemBuilder() : widget.itemBuilder().where((element) => element.searchValue.toLowerCase().contains(value.text.trim().toLowerCase())).toList();
              if(filteredItems.isEmpty){
                return const SizedBox.shrink();
              }
              return Material(
                type: MaterialType.transparency,
                elevation: 2,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                      ),
                      decoration: ShapeDecoration(
                        color: widget.menuBackgroundColor ?? context.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: context.colorScheme.outlineVariant.withOpacity(.2), width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x07191A1D),
                            blurRadius: 8,
                            offset: Offset(0, 8),
                            spreadRadius: -4,
                          ),
                          BoxShadow(
                            color: Color(0x14191A1D),
                            blurRadius: 24,
                            offset: Offset(0, 20),
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: RawScrollbar(
                          radius: const Radius.circular(6),
                          thickness: 4,
                          crossAxisMargin: 5,
                          mainAxisMargin: 5,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index){
                                final currentValue = filteredItems[index];
                                final isSelected = currentValue.value == widget.initialSelection || currentValue.searchValue == _controller.text;
                                return Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () {
                                      if (widget.onItemSelected != null) {
                                        widget.onItemSelected!(currentValue.value);
                                      }
                                      else{
                                        _controller.text = currentValue.searchValue;
                                      }
                                      overlayEntry?.remove();
                                      overlayEntry = null;
                                    },
                                    child: Padding(
                                      padding: widget.menuItemPadding ?? const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          if(currentValue.leadingWidget != null)...[
                                            currentValue.leadingWidget!,
                                            const SizedBox(width: 10),
                                          ],
                                          if(currentValue.selectedLeadingWidget != null && isSelected)...[
                                            currentValue.selectedLeadingWidget!,
                                            const SizedBox(width: 10),
                                          ],
                                          if(currentValue.labelWidget != null)...[
                                            currentValue.labelWidget!,
                                          ],
                                          const Spacer(),
                                          if(currentValue.selectedTrailingWidget != null && isSelected)...[
                                            currentValue.selectedTrailingWidget!,
                                            const SizedBox(width: 10),
                                          ],
                                          if(currentValue.trailingWidget != null)...[
                                            const SizedBox(width: 10),
                                            currentValue.trailingWidget!,
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    ));
    overlayState.insert(overlayEntry!);
    isMenuOpen.value = true;
    widget.onMenuStateChanged?.call(true);
  }

  @override
  void dispose() {
    super.dispose();
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    key: _globalKey,
    width: widget.width,
    child: CompositedTransformTarget(
      link: _layerLink,
      child: AppTextField(
        focusNode: _focusNode,
        controller: _controller,
        keyboardType: widget.keyboardType,
        hint: widget.hint,
        label: widget.label,
        enabled: widget.enabled,
        borderColor: widget.borderColor,
        textColor: widget.textColor,
        textStyle: widget.textStyle,
        validator: widget.validator,
        height: widget.height,
        contentPadding: widget.contentPadding,
        readOnly: !widget.enableSearch,
        onTap: () {
          if(widget.showMenu && overlayEntry == null){
            _showOverlay(context);
          }
        },
        onFocusChanged: (hasFocus) {
          if(!hasFocus && overlayEntry != null) {
            overlayEntry?.remove();
            overlayEntry = null;
          }
          if(!hasFocus){
            isMenuOpen.value = false;
            widget.onMenuStateChanged?.call(false);
          }
        },
        onChanged: (value) {
          if(widget.enableSearch){
            if(overlayEntry == null){
              _showOverlay(context);
            }
          }
        },
        inputFormatters: widget.inputFormatters,
        suffix: InkWell(
          onTap: () {
            if(isMenuOpen.value && overlayEntry != null){
              overlayEntry?.remove();
              overlayEntry = null;
              isMenuOpen.value = false;
              widget.onMenuStateChanged?.call(false);
            } else {
              _showOverlay(context);
            }
          },
          child: ValueListenableBuilder(
              valueListenable: isMenuOpen,
              builder: (context,value,child) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(widget.trailingIcon != null) widget.trailingIcon!,
                  if(widget.trailingIcon == null)...[
                    if(!value)...[
                      Icon(Icons.keyboard_arrow_down_rounded, color: context.colorScheme.onSurface),
                      const SizedBox(width: 10),
                    ],
                    if(value)...[
                      Icon(Icons.keyboard_arrow_up_rounded, color: context.colorScheme.onSurface),
                      const SizedBox(width: 10),
                    ],
                  ],
                ],
              ),
          ),
        ),
        prefix: widget.leadingIcon != null ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(widget.leadingIcon != null) widget.leadingIcon!,
          ],
        ) : null,
      ),
    ),
  );

}
