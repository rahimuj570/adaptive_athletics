import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../res/colors/app_color.dart';

class CustomDropdown extends StatefulWidget {
  final dynamic controller; // RxString (single) or RxList<String> (multi)
  final List<String> items;
  final String title;

  // Title Text
  final double? titlePaddingBottom;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final String? titleFontFamily;
  final double? titleLetterSpacing;
  final EdgeInsets? titlePadding;

  // Container
  final double? height;
  final double? width;
  final EdgeInsets? containerPadding;
  final double? containerPaddingHorizontal;
  final double? containerPaddingVertical;

  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double borderRadius;

  final bool shadow;
  final Color? shadowColor;
  final double shadowBlur;
  final Offset shadowOffset;

  // Hint Text
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final double? hintFontSize;
  final FontWeight? hintFontWeight;
  final String? hintFontFamily;
  final double? hintLetterSpacing;

  // Selected Text
  final TextStyle? selectedTextStyle;
  final Color? selectedTextColor;
  final double? selectedTextFontSize;
  final FontWeight? selectedTextFontWeight;
  final String? selectedTextFontFamily;

  // Dropdown Icon
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;

  // Menu Popup
  final Color? menuBackgroundColor;
  final double? menuElevation;
  final EdgeInsets? menuPadding;

  // Menu Item Text
  final TextStyle? menuItemStyle;
  final Color? menuItemColor;
  final double? menuItemFontSize;
  final FontWeight? menuItemFontWeight;
  final String? menuItemFontFamily;

  // Multi Select
  final bool multiSelect;
  final bool useRawItems;

  // Dialog Style
  final Color? dialogBackgroundColor;
  final TextStyle? dialogTitleStyle;

  final Color? dialogTitleColor;
  final double? dialogTitleFontSize;
  final FontWeight? dialogTitleFontWeight;
  final String? dialogTitleFontFamily;
  final double? dialogTitleLetterSpacing;

  // Dialog items (checkbox text)
  final TextStyle? dialogItemStyle;
  final Color? dialogItemColor;
  final double? dialogItemFontSize;
  final FontWeight? dialogItemFontWeight;
  final String? dialogItemFontFamily;

  final Color? checkboxActiveColor;
  final double dialogRadius;

  // Initial Value
  final String? initialSingleValue;
  final List<String>? initialMultiValues;

  const CustomDropdown({
    super.key,
    required this.controller,
    required this.items,
    required this.title,

    // Title
    this.titlePaddingBottom = 0,
    this.titleStyle,
    this.titleColor = AppColor.defaultColor,
    this.titleFontSize = 12,
    this.titleFontWeight = FontWeight.w500,
    this.titleFontFamily = 'Roboto',
    this.titleLetterSpacing,
    this.titlePadding,

    // Container
    this.height = 48,
    this.width,
    this.containerPadding,
    this.containerPaddingHorizontal,
    this.containerPaddingVertical,
    this.backgroundColor = AppColor.textAreaColor4,
    this.borderColor = AppColor.textAreaColor4,
    this.borderWidth = .0,
    this.borderRadius = 6,
    this.shadow = false,
    this.shadowColor,
    this.shadowBlur = 6,
    this.shadowOffset = const Offset(0, 3),

    // Hint
    this.hintText,
    this.hintStyle,
    this.hintColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.hintFontFamily = 'Roboto',
    this.hintLetterSpacing,

    // Selected text
    this.selectedTextStyle,
    this.selectedTextColor = AppColor.whiteColor,
    this.selectedTextFontSize,
    this.selectedTextFontWeight,
    this.selectedTextFontFamily = 'Roboto',

    // Icon
    this.icon = Icons.keyboard_arrow_down_rounded,
    this.iconColor = AppColor.whiteColor,
    this.iconSize,

    // Menu
    this.menuBackgroundColor = AppColor.textAreaColor5,
    this.menuElevation,
    this.menuPadding,

    // Menu items
    this.menuItemStyle,
    this.menuItemColor = AppColor.whiteColor,
    this.menuItemFontSize,
    this.menuItemFontWeight,
    this.menuItemFontFamily = 'Roboto',

    // Behavior
    this.multiSelect = false,
    this.useRawItems = false,

    // Dialog Title
    this.dialogBackgroundColor,
    this.dialogTitleStyle,
    this.dialogTitleColor,
    this.dialogTitleFontSize,
    this.dialogTitleFontWeight,
    this.dialogTitleFontFamily = 'Roboto',
    this.dialogTitleLetterSpacing,

    // Dialog item (checkbox text)
    this.dialogItemStyle,
    this.dialogItemColor,
    this.dialogItemFontSize,
    this.dialogItemFontWeight,
    this.dialogItemFontFamily = 'Roboto',

    this.checkboxActiveColor,
    this.dialogRadius = 12,

    // Initial Value
    this.initialSingleValue,
    this.initialMultiValues,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize values after the widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeValues();
    });
  }

  void _initializeValues() {
    if (_isInitialized) return;

    if (!widget.multiSelect &&
        widget.initialSingleValue != null &&
        widget.controller is RxString) {
      final RxString rx = widget.controller;
      if (rx.value.isEmpty) {
        rx.value = widget.initialSingleValue!;
      }
    }

    if (widget.initialMultiValues != null &&
        widget.controller is RxList<String>) {
      final RxList<String> rxList = widget.controller;
      if (rxList.isEmpty) {
        rxList.clear();
        rxList.addAll(widget.initialMultiValues!);
      }
    }

    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title.isNotEmpty) _buildTitle(),
          SizedBox(height: 6.h),
          _buildContainer(context),
        ],
      ),
    );
  }

  // ----------------------
  // TITLE
  // ----------------------
  Widget _buildTitle() {
    return Padding(
      padding:
          widget.titlePadding ??
          EdgeInsets.only(bottom: widget.titlePaddingBottom!.h),
      child: Text(
        widget.title,
        style:
            widget.titleStyle ??
            TextStyle(
              color: widget.titleColor ?? Colors.black,
              fontSize: (widget.titleFontSize ?? 14).sp,
              fontWeight: widget.titleFontWeight ?? FontWeight.w500,
              fontFamily: widget.titleFontFamily,
              letterSpacing: widget.titleLetterSpacing,
            ),
      ),
    );
  }

  // ----------------------
  // CONTAINER
  // ----------------------
  Widget _buildContainer(BuildContext context) {
    return Container(
      width: widget.width?.w ?? double.infinity,
      height: widget.height?.h ?? 46.h,
      padding: EdgeInsets.symmetric(
        horizontal: widget.containerPaddingHorizontal ?? 12.w,
        vertical: widget.containerPaddingVertical ?? 0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColor.whiteColor,
        borderRadius: BorderRadius.circular(widget.borderRadius.r),
        border: Border.all(
          color: widget.borderColor ?? Colors.grey.shade300,
          width: widget.borderWidth?.r ?? 1.r,
        ),
        boxShadow: widget.shadow
            ? [
                BoxShadow(
                  color: widget.shadowColor ?? Colors.black12,
                  blurRadius: widget.shadowBlur,
                  offset: widget.shadowOffset,
                ),
              ]
            : [
                BoxShadow(
                  color:
                      widget.shadowColor ??
                      AppColor.boxShadowColor.withAlpha(27),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
      ),
      child: widget.multiSelect
          ? _buildMultiSelect(context)
          : _buildSingleSelect(context),
    );
  }

  // ----------------------
  // SINGLE SELECT
  // ----------------------
  Widget _buildSingleSelect(BuildContext context) {
    final RxString rx = widget.controller;

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: rx.value.isEmpty ? null : rx.value,
        icon: Icon(
          widget.icon,
          color: widget.iconColor ?? Colors.black,
          size: widget.iconSize ?? 22.sp,
        ),
        dropdownColor: widget.menuBackgroundColor ?? AppColor.whiteColor,
        elevation: widget.menuElevation?.toInt() ?? 4,

        // Selected text styling
        style:
            widget.selectedTextStyle ??
            TextStyle(
              fontSize: (widget.selectedTextFontSize ?? 14).sp,
              color: widget.selectedTextColor ?? Colors.black87,
              fontWeight: widget.selectedTextFontWeight ?? FontWeight.w500,
              fontFamily: widget.selectedTextFontFamily,
            ),

        hint: Text(
          widget.hintText ?? "Select",
          style:
              widget.hintStyle ??
              TextStyle(
                fontSize: (widget.hintFontSize ?? 14).sp,
                color: widget.hintColor ?? Colors.grey.shade600,
                fontWeight: widget.hintFontWeight ?? FontWeight.w400,
                fontFamily: widget.hintFontFamily,
                letterSpacing: widget.hintLetterSpacing,
              ),
        ),

        onChanged: (value) => rx.value = value ?? '',

        items: widget.items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              widget.useRawItems ? item : item.tr,
              style:
                  widget.menuItemStyle ??
                  TextStyle(
                    fontSize: (widget.menuItemFontSize ?? 14).sp,
                    color: widget.menuItemColor ?? Colors.black87,
                    fontWeight: widget.menuItemFontWeight ?? FontWeight.w400,
                    fontFamily: widget.menuItemFontFamily,
                  ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ----------------------
  // MULTI SELECT - FIXED WITH SCROLLABLE
  // ----------------------
  Widget _buildMultiSelect(BuildContext context) {
    final RxList<String> selected = widget.controller;
    //
    // final String label =
    // selected.isEmpty ? (widget.hintText ?? "Select") : selected.join(", ");

    return InkWell(
      onTap: () => _showMultiSelectDialog(context, selected),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                selected.isEmpty
                    ? widget.hintText ?? 'select_option'.tr
                    : selected
                          .map((item) => widget.useRawItems ? item : item.tr)
                          .join(', '),
                style: selected.isEmpty
                    ? (widget.hintStyle ??
                          TextStyle(
                            fontSize: (widget.hintFontSize ?? 14).sp,
                            color: widget.hintColor ?? Colors.grey.shade600,
                            fontWeight:
                                widget.hintFontWeight ?? FontWeight.w400,
                            fontFamily: widget.hintFontFamily,
                          ))
                    : (widget.selectedTextStyle ??
                          TextStyle(
                            fontSize: (widget.selectedTextFontSize ?? 14).sp,
                            color: widget.selectedTextColor ?? Colors.black87,
                            fontWeight:
                                widget.selectedTextFontWeight ??
                                FontWeight.w500,
                            fontFamily: widget.selectedTextFontFamily,
                          )),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Icon(
            widget.icon,
            color: widget.iconColor ?? Colors.black,
            size: widget.iconSize ?? 22.sp,
          ),
        ],
      ),
    );
  }

  // ----------------------
  // MULTI SELECT DIALOG
  // ----------------------
  Future<void> _showMultiSelectDialog(
    BuildContext context,
    RxList<String> selected,
  ) async {
    final temp = RxList<String>(selected);

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: widget.dialogBackgroundColor ?? AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.dialogRadius.r),
          ),
          title: Text(
            widget.title,
            style:
                widget.dialogTitleStyle ??
                TextStyle(
                  color: widget.dialogTitleColor ?? Colors.black,
                  fontSize: (widget.dialogTitleFontSize ?? 16).sp,
                  fontWeight: widget.dialogTitleFontWeight ?? FontWeight.bold,
                  fontFamily: widget.dialogTitleFontFamily,
                  letterSpacing: widget.dialogTitleLetterSpacing,
                ),
          ),
          content: Obx(() {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.items.map((item) {
                  return CheckboxListTile(
                    value: temp.contains(item),
                    activeColor: widget.checkboxActiveColor ?? Colors.blue,
                    title: Text(
                      widget.useRawItems ? item : item.tr,
                      style:
                          widget.dialogItemStyle ??
                          TextStyle(
                            fontSize: (widget.dialogItemFontSize ?? 14).sp,
                            color: widget.dialogItemColor ?? Colors.black87,
                            fontWeight:
                                widget.dialogItemFontWeight ?? FontWeight.w400,
                            fontFamily: widget.dialogItemFontFamily,
                          ),
                    ),
                    onChanged: (checked) {
                      checked == true ? temp.add(item) : temp.remove(item);
                    },
                  );
                }).toList(),
              ),
            );
          }),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(Get.context!),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                selected.assignAll(temp);

                Navigator.pop(Get.context!);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
