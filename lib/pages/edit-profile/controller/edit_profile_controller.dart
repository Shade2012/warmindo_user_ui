import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import '../../../common/global_variables.dart';
import 'package:http/http.dart' as http;
import '../../profile_page/controller/profile_controller.dart';

class EditProfileController extends GetxController {
  final ProfileController profileController = Get.put(ProfileController());
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final usernameController = TextEditingController();
  RxBool isConnected = true.obs;
  SharedPreferences? prefs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isLoading = true.obs;
  RxString txtUsername = "".obs;
  RxString txtName = "".obs;
  RxString txtEmail = "".obs;
  RxString txtNomorHp = "".obs;
  RxString token = "".obs;
  RxString imgProfile = "".obs;
  RxString user_phone_verified = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkConnectivity();
  }
  Future<void> initializePrefs() async {
    prefs ??= await SharedPreferences.getInstance();
  }
  void fetchUser() async{
    token.value = prefs!.getString('token') ?? '';
    try {
      isLoading.value = true; // Set loading to true before fetching data
      final response = await http.get(Uri.parse(GlobalVariables.apiDetailUser),headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success']) {
          txtName.value = data['user']['name'];
          txtUsername.value = data['user']['username'];
          txtEmail.value = data['user']['email'];
          txtNomorHp.value = data['user']['phone_number'] ?? '';
          imgProfile.value = data['user']['profile_picture'] ?? '';
          user_phone_verified.value = data['user']['phone_verified_at'] ?? '';
          usernameController.text = txtUsername.value;
          fullNameController.text = txtName.value;
          phoneNumberController.text = txtNomorHp.value;
          emailController.text = txtEmail.value;
          print("Fetched username: ${txtUsername.value}");
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
  void checkSharedPreference() async {
    await initializePrefs();
    if (prefs != null) {
      fetchUser();
    }
  }
  void checkConnectivity() async {
    await initializePrefs();
    if (prefs != null) {
      txtUsername.value = prefs!.getString('username') ?? '';
      token.value = prefs!.getString('token') ?? '';
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        checkSharedPreference();
      }
    });

    var connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
    if (isConnected.value) {
      checkSharedPreference();
    }
  }

  Future<void> editProfile({
    String? name,
    String? username,
    String? email,
    File? image,
  }) async {
    final url = Uri.parse(GlobalVariables.apiUpdatePhoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      isLoading.value = true;
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name ?? ''
        ..fields['username'] = username ?? ''
        ..fields['email'] = email ?? '';

      if (image != null) {
        final fileExtension = path.extension(image.path);
        final fileName = 'profile_picture$fileExtension';
        request.files.add(http.MultipartFile(
          'profile_picture',
          image.readAsBytes().asStream(),
          image.lengthSync(),
          filename: fileName,
        ));
      }
      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        isLoading.value = false;
        profileController.checkSharedPreference();
        Get.toNamed(Routes.BOTTOM_NAVBAR);
        Get.snackbar(
          'Success',
          'Berhasil Dirubah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 400) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Password Saat ini tidak sesuai',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response.statusCode == 422) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Password Tidak Sama',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = false;
        print('error biasa : ${response.body}');
        Get.snackbar(
          'Error biasa',
          'Error: ${response.statusCode} ${response.body}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error Catch',
        'Error occurred: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('$e');
    } finally {
      isLoading.value = false;
    }
  }



  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path); // Store image as File
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error',
          'Tidak ada gambar yang dipilih',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
    }
  }

}
