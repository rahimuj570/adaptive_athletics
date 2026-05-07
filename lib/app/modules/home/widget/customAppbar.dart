import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newproject/res/assets/image_assets.dart';
import 'package:newproject/res/colors/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onBack,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.h); // Adjust height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.blackColor,
      elevation: 0,
      leadingWidth: 60.w,
      leading: InkWell(
        onTap: onBack ?? () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SvgPicture.asset(ImageAssets.backward),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 20.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h), // spacing between title and subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.textAreaColor2,
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
