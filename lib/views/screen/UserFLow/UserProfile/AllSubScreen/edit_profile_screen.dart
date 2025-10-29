import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Edit Profile",),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/images/demo.png'),
                  fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.30),
                      BlendMode.darken)),

                ),
              ),
              Positioned(
               bottom: 5,
                right: 145,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF012F64)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset('assets/icons/camera.svg'),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 24,),
          CustomTextField(
            hintText: "Enter full name",
          ),
          SizedBox(height: 62,),
          CustomButton(onTap: (){},
              text: "Save Now")
        ],
      ),
    );
  }
}
