import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../controller/change_pass_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Center(child: Text("Ubah Password",style: headerRegular,)),
                  SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Untuk mengubah password, silakan isi formulir di bawah ini:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20.0),
                        typePass(
                          TextInputType.text,
                          "Password Lama",
                          "Masukkan password lama",
                          _currentPasswordController,
                          (value) {
                            if (value.isEmpty) {
                              return "Password Lama diperlukan";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        typePass(
                          TextInputType.text,
                          "Password Baru",
                          "Masukkan password baru",
                          _newPasswordController,
                          (value) {
                            if (value.isEmpty) {
                              return "Password Baru diperlukan";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        typePass(
                          TextInputType.text,
                          "Konfirmasi Password Baru",
                          "Konfirmasi password baru",
                          _confirmNewPasswordController,
                          (value) {
                            if (value.isEmpty) {
                              return "Konfirmasi Password Baru diperlukan";
                            }
                            if (_newPasswordController.text != value) {
                              return "Password Baru dan Konfirmasi Password Baru tidak sama";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: ColorResources.secondaryTextColor,
                            minimumSize: Size(400, 46),
                            padding: EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            if (_currentPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Password Lama Kosong"),
                                ),
                              );
                            }

                            else if(_newPasswordController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Password baru Kosong"),
                                ),
                              );
                            }else if(_confirmNewPasswordController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Konfirmasi password Kosong"),
                                ),
                              );
                            }
                            else {
                              controller.confirmPassword(password: _newPasswordController.text, current_password: _currentPasswordController.text, password_confirmation: _confirmNewPasswordController.text);
                            }
                          },
                          child: Text("Ubah Password"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          if (controller.isLoading.value == true) {
            return Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }
}

Widget typePass(
    TextInputType keyboardType,
    String label,
    String hint,
    TextEditingController controller,
    String? Function(String)? validator,
    ) {
  return Container(
    margin: EdgeInsets.only(top: 20, bottom: 20),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        hintText: hint,

        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey, // Label color is always grey
        ),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12,fontWeight: FontWeight.normal),
        errorStyle: TextStyle(color: Colors.black), // Error text color is black

      ),
    ),
  );
}


