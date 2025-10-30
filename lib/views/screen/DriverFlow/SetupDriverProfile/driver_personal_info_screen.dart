import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_profile_setup_controller.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_dropdown.dart';
import 'package:radeef/views/base/custom_text_field.dart';
import 'package:radeef/views/screen/DriverFlow/SetupDriverProfile/driver_verify_identity_screen.dart';

class DriverPersonalInfoScreen extends StatefulWidget {
  const DriverPersonalInfoScreen({super.key});

  @override
  State<DriverPersonalInfoScreen> createState() => _DriverPersonalInfoScreenState();
}

class _DriverPersonalInfoScreenState extends State<DriverPersonalInfoScreen> {


  final _driverSetupController = Get.put(DriverProfileSetupController());

  Map<String, String> genderMap = {
    "Male": "Male",
    "Female": "Female",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios,
            color: Color(0xFF676769),),
            Text("2 Of 4",
            style: TextStyle(
              color: Color(0xFF012F64),
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Obx(
          ()=> Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: _driverSetupController.driverProfileImage.value != null?
                        FileImage(_driverSetupController.driverProfileImage.value!):

                    AssetImage('assets/images/demo.png'),
                    fit: BoxFit.cover)
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 130,
                child: InkWell(
                  onTap: (){
                    _driverSetupController.pickDriverImage();
                  },
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF012F64)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset('assets/icons/camera.svg'),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 24,),
          CustomTextField(
            hintText: "Enter Full Name",),
          SizedBox(height: 12,),
          CustomTextField(

            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/icons/calender.svg"),
            ),
            hintText: "Date Of birth",),
          SizedBox(height: 12,),
          CustomDropdown(
              title: "Gender",
              options: genderMap.values.toList(),
              onChanged: (val){
                setState(() {

                });
              }),
          SizedBox(height: 12,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
                color: Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(4)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vehicle Registration",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454)
                  ),),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Upload",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF545454)
                            ),),


                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image = _driverSetupController.vehicleImage.value;
                                return Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: image != null ? const Color(0xFF11DF7F) : const Color(0xFF012F64),
                                      width: 0.5,
                                    ),
                                    color: image == null ? const Color(0xFFE6E6E6) : null,
                                  ),
                                  child: image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : null,
                                );
                              }),

                              Obx(() {
                                return _driverSetupController.vehicleImage.value == null
                                    ? Positioned(
                                  child: InkWell(
                                    onTap: () {
                                      _driverSetupController.pickVehicleImage();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                        color: const Color(0xFF012F64),
                                      ),
                                    ),
                                  ),
                                )
                                    : const SizedBox.shrink(); // Hide icon when image exists
                              }),
                            ],
                          )


                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
                color: Color(0xFFE6E6E6),
                borderRadius: BorderRadius.circular(4)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vehicle Photo",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF545454)
                  ),),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Image (Front Side)",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF545454)
                            ),),


                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image = _driverSetupController.frontImage.value;
                                return Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: image != null ? const Color(0xFF11DF7F) : const Color(0xFF012F64),
                                      width: 0.5,
                                    ),
                                    color: image == null ? const Color(0xFFE6E6E6) : null,
                                  ),
                                  child: image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : null,
                                );
                              }),

                              Obx(() {
                                return _driverSetupController.frontImage.value == null
                                    ? Positioned(
                                  child: InkWell(
                                    onTap: () {
                                      _driverSetupController.pickFrontImage();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                        color: const Color(0xFF012F64),
                                      ),
                                    ),
                                  ),
                                )
                                    : const SizedBox.shrink(); // Hide icon when image exists
                              }),
                            ],
                          )


                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Image (Back Side)",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF545454)
                            ),),


                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image = _driverSetupController.backImage.value;
                                return Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: image != null ? const Color(0xFF11DF7F) : const Color(0xFF012F64),
                                      width: 0.5,
                                    ),
                                    color: image == null ? const Color(0xFFE6E6E6) : null,
                                  ),
                                  child: image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : null,
                                );
                              }),

                              Obx(() {
                                return _driverSetupController.backImage.value == null
                                    ? Positioned(
                                  child: InkWell(
                                    onTap: () {
                                      _driverSetupController.pickBackImage();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                        color: const Color(0xFF012F64),
                                      ),
                                    ),
                                  ),
                                )
                                    : const SizedBox.shrink(); // Hide icon when image exists
                              }),
                            ],
                          )


                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 40,),
          CustomButton(onTap: (){
            Get.to(()=> DriverVerifyIdentityScreen());
          },
              text: "Save Now")
        ],
      ),
    );
  }
}
