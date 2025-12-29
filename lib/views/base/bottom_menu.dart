
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_icons.dart';


import '../../utils/app_colors.dart';

class BottomMenu extends StatelessWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.primaryColor : theme.disabledColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: const EdgeInsets.only(top:8),
          child: SvgPicture.asset(
            image,
            height: 24.0,
            width: 24.0,
            color: colorByIndex(theme, index),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(AppIcons.homeIcon, 'Home', theme, 0),
      getItem(AppIcons.rider, 'Riders', theme, 1),
      getItem(AppIcons.earn, 'Earn', theme, 2),
      getItem(AppIcons.profileIcon, 'Profile', theme, 2),
    ];

    return Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)
          ),
         
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),topLeft: Radius.circular(20.r)

        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:Color(0xFFfafafa),//0xFFfafafa
          selectedItemColor: Color(0xFF012F64),
          unselectedItemColor: Color(0xFF333333),
          selectedLabelStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          currentIndex: menuIndex,
          
          onTap: (value) {
            switch (value) {
              case 0:
                Get.offAndToNamed(AppRoutes.driverHomeScreen);
                break;
              case 1:
                Get.offAndToNamed(AppRoutes.driverRidesScreen);
                break;
              case 2:
                Get.offAndToNamed(AppRoutes.driverEarnScreen);
                break;

              case 3:
                Get.offAndToNamed(AppRoutes.driverProfileScreen);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}