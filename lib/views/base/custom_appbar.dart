import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  const CustomAppbar({super.key,  this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Colors.white,
      elevation: 0,
      title: Text(title ?? "",style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF333333)
      ),),
      leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios,color: Color(0xFF0D1C12),
          size: 18,),
      ),

    );
  }


  @override

  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}