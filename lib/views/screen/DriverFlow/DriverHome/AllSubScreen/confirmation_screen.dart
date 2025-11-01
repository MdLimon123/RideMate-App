import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_parcel_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/rate_pessengers_screen.dart';

class ConfirmationScreen extends StatefulWidget {

  final bool isParcel;
  const ConfirmationScreen({super.key, required this.isParcel});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {

  final _driverParcelController = Get.put(DriverParcelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 162,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: const Color(0xFF345983),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/demo.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "Sergio Romasis",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    width: 158,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/cycle.svg"),
                        const SizedBox(width: 4),
                        const Text(
                          "Trip",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333)),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "4",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333)),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.star,
                          color: Color(0xFF012F64),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "4.6",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333)),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 34,),
                widget.isParcel? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Take a picture for end trip",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor
                      ),),

                      Obx(() {
                        final image = _driverParcelController.parcelImage.value;
                        return InkWell(
                          onTap: (){
                            _driverParcelController.pickParcelImage(fromCamera: true);
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Color(0xFF11DF7F),
                                width: 0.5,
                              ),
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
                          ),
                        );
                      }),


                    ],
                  ),
                ): SizedBox(),

                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/pick.svg'),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown ",
                              style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/location.svg',
                              color: AppColors.textColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown ",
                              style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 12,),
                      widget.isParcel ? Row(
                          children: [
                            SvgPicture.asset("assets/icons/box.svg"),
                            SizedBox(width: 12,),
                            Text( "228",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF012F64)
                              ),
                            ),
                            SizedBox(width: 4,),
                            Text("(XAF)",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: AppColors.textColor
                              ),)
                          ]): SizedBox(),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/location.svg',
                              color: AppColors.textColor),
                          const SizedBox(width: 12),
                          const Text(
                            "28",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF012F64)),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(XAF)",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w200,
                                color: AppColors.textColor),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: const Color(0xFFE6EAF0)),
                  child: SvgPicture.asset('assets/icons/phone.svg'),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: const Color(0xFFE6EAF0)),
                    child: SvgPicture.asset('assets/icons/message.svg'),
                  ),
                ),
                const SizedBox(width: 22),
                InkWell(
                  onTap: () {

                  },
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFE6E6E6).withValues(alpha: 0.50)),
                    child: Center(
                        child: Text(
                          "Navigate",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        )),
                  ),
                ),

                /// Start/End Trip button

                // Start Trip button

                     InkWell(
                  onTap: ()  {
                    Get.to(()=> RatePessengersScreen());
                  },
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xFF345983),
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )




              ],
            ),
          )
        ],
      ),
    );
  }
}
