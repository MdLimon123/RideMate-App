import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/DriverFlow/SetupDriverProfile/driver_verify_identity_screen.dart';
import 'package:radeef/views/screen/DriverFlow/SetupDriverProfile/driver_verify_success_screen.dart';
import 'package:radeef/views/screen/DriverFlow/SetupDriverProfile/vehicle_setup_screen.dart';

class DriverProfileSetupController extends GetxController {
  var isLoading = false.obs;

  Rx<File?> driverProfileImage = Rx<File?>(null);
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);
  Rx<File?> vehicleImage = Rx<File?>(null);

  Rx<File?> nIdfrontImage = Rx<File?>(null);
  Rx<File?> nIdbackImage = Rx<File?>(null);

  Rx<File?> vfrontImage = Rx<File?>(null);
  Rx<File?> vbackImage = Rx<File?>(null);

  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  XFile? capturedImage;
  RxBool isPermissionGranted = false.obs;

  var selectedGender = ''.obs;

  Map<String, String> genderMap = {"Male": "Male", "Female": "Female"};

  /// Pick image from camera or gallery
  Future<void> pickVehicleImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      vehicleImage.value = pickedFile;
    }
  }

  /// Pick image from camera or gallery
  Future<void> pickDriverImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      driverProfileImage.value = pickedFile;
    }
  }

  /// Pick nid image front camera or gallery
  ///

  Future<void> pickVFrontImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      vfrontImage.value = pickedFile;
    }
  }

  Future<void> pickVBackImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      vbackImage.value = pickedFile;
    }
  }

  Future<void> pickNIDFrontImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      nIdfrontImage.value = pickedFile;
    }
  }

  Future<void> pickNIDBackImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      nIdbackImage.value = pickedFile;
    }
  }

  /// Pick nid image front camera or gallery
  Future<void> pickFrontImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      frontImage.value = pickedFile;
    }
  }

  /// Pick nid image back camera or gallery
  Future<void> pickBackImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      backImage.value = pickedFile;
    }
  }

  Future<void> uploadCaptureImage({required String imagePath}) async {
    isLoading(true);

    List<MultipartBody> multipartBody = [];

    if (imagePath.isNotEmpty) {
      multipartBody.add(MultipartBody('avatar', File(imagePath)));
    }

    final response = await ApiClient.postMultipartData(
      "/profile/upload-capture-avatar",
      {},
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => DriverVerifySuccessScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

  Future<void> setupUserProfile({
    required String avatar,
    required String drivingLicenseFront,
    required String drivingLicenseBack,
    required String nIdFornt,
    required String nIdBack,
    required String name,
    required String dateOfBirth,
    required String gender,
  }) async {
    isLoading(true);

    /// Multipart files
    final List<MultipartBody> multipartBody = [];

    if (avatar.isNotEmpty) {
      multipartBody.add(MultipartBody('avatar', File(avatar)));
    }

    if (drivingLicenseFront.isNotEmpty) {
      multipartBody.add(
        MultipartBody('driving_license_photos', File(drivingLicenseFront)),
      );
    }
    if (drivingLicenseBack.isNotEmpty) {
      multipartBody.add(
        MultipartBody('driving_license_photos', File(drivingLicenseBack)),
      );
    }

    if (nIdFornt.isNotEmpty) {
      multipartBody.add(MultipartBody('nid_photos', File(nIdFornt)));
    }

    if (nIdBack.isNotEmpty) {
      multipartBody.add(MultipartBody('nid_photos', File(nIdBack)));
    }

    final Map<String, String> formData = {
      "name": name,
      "date_of_birth": dateOfBirth,
      "gender": gender,
    };

    final response = await ApiClient.postMultipartData1(
      "/profile/setup-driver-profile",
      formData,
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => VehicleSetupScreen());
    } else {
      debugPrint("❌ Error Response: ${response.body}");
      showCustomSnackBar(response.statusText ?? "Something went wrong");
    }

    isLoading(false);
  }

  Future<void> uploadVehicleInfo({
    required String vType,
    required String vBrand,
    required String vModel,
    required String licenseNumber,
    required String vImage,
    required String vFrontImage,
    required String vBackImage,
  }) async {
    isLoading(true);

    final List<MultipartBody> multipartBody = [];

    if (vImage.isNotEmpty) {
      multipartBody.add(
        MultipartBody('vehicle_registration_photos', File(vImage)),
      );
    }

    if (vFrontImage.isNotEmpty) {
      multipartBody.add(MultipartBody('vehicle_photos', File(vFrontImage)));
    }
    if (vBackImage.isNotEmpty) {
      multipartBody.add(MultipartBody('vehicle_photos', File(vBackImage)));
    }

    final Map<String, String> formData = {
      "vehicle_type": vType,
      "vehicle_brand": vBrand,
      "vehicle_model": vModel,
      "vehicle_plate_number": licenseNumber,
    };

    final response = await ApiClient.postMultipartData1(
      "/profile/setup-vehicle",
      formData,
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => DriverVerifyIdentityScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

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

  ///  Step 3: Capture selfie safely
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

  ///  Step 4: Retake selfie safely
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
