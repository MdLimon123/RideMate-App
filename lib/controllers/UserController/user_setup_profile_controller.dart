import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/UserFLow/SetupProfile/verify_identity_screen.dart';
import 'package:radeef/views/screen/UserFLow/SetupProfile/verify_success_screen.dart';

class UserSetupProfileController extends GetxController {
  Rx<File?> userProfileImage = Rx<File?>(null);
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);

  var isLoading = false.obs;

  var selectedGender = ''.obs;

  CameraController? cameraController;
  RxBool isCameraInitialized = false.obs;
  XFile? capturedImage;
  RxBool isPermissionGranted = false.obs;

  Map<String, String> genderMap = {"Male": "Male", "Female": "Female"};


  Future<void> pickCoachImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      userProfileImage.value = pickedFile;
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

Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
 
    if (Platform.isIOS) {
      await initCamera();
    } else {
      if (status.isGranted) {
        isPermissionGranted.value = true;
        // if (Platform.isIOS) {
        //   await Future.delayed(const Duration(milliseconds: 200));
        // }
        await initCamera();
        return true;
      } else if (status.isDenied) {
        status = await Permission.camera.request();
        if (status.isGranted) {
          isPermissionGranted.value = true;
          if (Platform.isAndroid) {
            await Future.delayed(const Duration(milliseconds: 200));
          }
          await initCamera();
          return true;
        } else {
          Get.snackbar(
            "Permission Denied",
            "Camera permission is required to verify your identity.",
          );
          return false;
        }
      } else if (status.isPermanentlyDenied) {
        Get.snackbar(
          "Permission Denied",
          "Please enable camera permission from iOS settings.",
        );
        return false;
      }
    }
 
    return false;
  }
 
  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      CameraDescription? frontCamera;
      try {
        frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
        );
      } catch (_) {
        frontCamera = cameras.isNotEmpty ? cameras.first : null;
      }
 
      if (frontCamera == null) {
        Get.snackbar("Camera Error", "No cameras found on device.");
        return;
      }
 
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

  Future<void> setupUserProfile({
    required String avatar,
    required String nIdFornt,
    required String nIdBack,
    required String name,
    required String dateOfBirth,
    required String gender,
  }) async {
    isLoading(true);
    List<MultipartBody> multipartBody = [];

    if (avatar.isNotEmpty) {
      multipartBody.add(MultipartBody('avatar', File(avatar)));
    }

    if (nIdFornt.isNotEmpty) {
      multipartBody.add(MultipartBody('nid_photos', File(nIdFornt)));
    }

    if (nIdBack.isNotEmpty) {
      multipartBody.add(MultipartBody('nid_photos', File(nIdBack)));
    }

    Map<String, String> fromData = {
      "name": name,
      "date_of_birth": dateOfBirth,
      "gender": gender,
    };

    final response = await ApiClient.postMultipartData(
      "/profile/setup-user-profile",
      fromData,
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => VerifyIdentityScreen());
    } else {
      showCustomSnackBar(response.statusText);
    }

    isLoading(false);
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
      Get.to(() => VerifySuccessScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
