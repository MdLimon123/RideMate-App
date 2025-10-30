import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:radeef/utils/image_utils.dart';

class DriverProfileSetupController extends GetxController{

  Rx<File?> driverProfileImage = Rx<File?>(null);
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);
  Rx<File?> vehicleImage = Rx<File?>(null);

  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  XFile? capturedImage;
  RxBool isPermissionGranted = false.obs;

/// Pick image from camera or gallery
  Future<void> pickVehicleImage({bool fromCamera = false})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      vehicleImage.value = pickedFile;
    }

  }

  /// Pick image from camera or gallery
  Future<void> pickDriverImage({bool fromCamera = false})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      driverProfileImage.value = pickedFile;
    }

  }

  /// Pick nid image front camera or gallery


  /// Pick nid image front camera or gallery
  Future<void> pickFrontImage({bool fromCamera = false})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      frontImage.value = pickedFile;
    }

  }

  /// Pick nid image back camera or gallery
  Future<void> pickBackImage({bool fromCamera = false})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      backImage.value = pickedFile;
    }

  }

  /// 🔹 Step 1: Request Camera Permission
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      isPermissionGranted.value = true;
      await initCamera();
    } else {
      Get.snackbar(
        "Permission Denied",
        "Camera permission is required to verify your identity.",
      );
    }
  }

  /// 🔹 Step 2: Initialize front camera safely
  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      final controller = CameraController(frontCamera, ResolutionPreset.medium);
      await controller.initialize();

      cameraController = controller;
      isCameraInitialized.value = true;
    } catch (e) {
      Get.snackbar("Camera Error", e.toString());
    }
  }

  /// 🔹 Step 3: Capture selfie safely
  Future<void> captureSelfie() async {
    final controller = cameraController;

    if (controller == null || !controller.value.isInitialized) {
      Get.snackbar("Error", "Camera not ready!");
      return;
    }

    try {
      final image = await controller.takePicture();
      capturedImage = image;


      isCameraInitialized.value = false;


      await Future.delayed(const Duration(milliseconds: 300));

      await controller.dispose();
      cameraController = null;

      Get.snackbar("Success", "Selfie captured successfully!");
    } catch (e) {
      Get.snackbar("Capture Failed", e.toString());
    }
  }

  /// 🔹 Step 4: Retake selfie safely
  Future<void> retakeSelfie() async {
    try {

      final controller = cameraController;
      cameraController = null;
      isCameraInitialized.value = false;

      await controller?.dispose();


      capturedImage = null;


      await Future.delayed(const Duration(milliseconds: 200));
      await initCamera();
    } catch (e) {
      Get.snackbar("Camera Error", e.toString());
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }


}