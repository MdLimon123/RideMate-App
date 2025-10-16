
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/user_setup_profile_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';

class VerifyIdentityScreen extends StatefulWidget {
  const VerifyIdentityScreen({super.key});

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {

  final _setupProfileController = Get.put(UserSetupProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions:  [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('3 Of 3', style: TextStyle(color: Color(0xFF012F64),
            fontWeight: FontWeight.w500,
            fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(() {
    
          if (!_setupProfileController.isPermissionGranted.value) {
            return  Center(
              child: Text(
                "Camera permission required to continue.",
                style: TextStyle(fontSize: 16,
                fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            );
          }

          // Camera initializing
          if (_setupProfileController.isCameraInitialized.value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CameraPreview(_setupProfileController.cameraController!,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          onPressed: _setupProfileController.captureSelfie,
                          child: const Icon(Icons.camera_alt,
                              color: Colors.black, size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

              ],
            );
          }

          // Selfie captured ✅
          else if (_setupProfileController.capturedImage != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(
                        File(_setupProfileController.capturedImage!.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                 Text(
                  "Verify Your Identity",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,
                  color: AppColors.textColor),
                ),
                const SizedBox(height: 16),
                 Text(
                  "Take a quick selfie to complete your profile",
                  style: TextStyle(fontSize: 16, color: AppColors.textColor,
                  fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 240),


                CustomButton(
                  onTap: () {

                  },
                  text: "Confirm & Continue",
                ),

                const SizedBox(height: 16),


                TextButton(
                  onPressed: _setupProfileController.retakeSelfie,
                  child: const Text(
                    "Retake Selfie",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          }

          // Loading indicator
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
