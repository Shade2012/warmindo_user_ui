import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../routes/AppPages.dart';
import '../controller/change_pass_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  ChangePasswordPage({super.key});

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
                  const SizedBox(height: 20,),
                  Center(child: Text("Ubah Password",style: headerRegular,)),
                  const SizedBox(height: 20,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Untuk mengubah password, silakan isi formulir di bawah ini:",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20.0),
                        typePass(
                            TextInputType.text,
                            "Password Lama",
                            _currentPasswordController,
                                (value) {
                              if (value!.isEmpty) {
                                return "Password Lama diperlukan";
                              }
                              return null;
                            }, false.obs
                        ),
                        const SizedBox(height: 20.0),
                        typePass(
                            TextInputType.text,
                            "Password Baru",
                            _newPasswordController,
                                (value) {
                              if (value!.isEmpty) {
                                return "Password Baru diperlukan";
                              }
                              if (value.length < 8) {
                                return "Password Baru harus terdiri dari minimal 8 karakter";
                              }
                              return null;
                            }, false.obs
                        ),
                        const SizedBox(height: 20.0),
                        typePass(
                            TextInputType.text,
                            "Konfirmasi Password Baru",
                            _confirmNewPasswordController,
                                (value) {
                              if (value!.isEmpty) {
                                return "Konfirmasi Password Baru diperlukan";
                              }
                              if (_newPasswordController.text != value) {
                                return "Password Baru dan Konfirmasi Password Baru tidak sama";
                              }
                              return null;
                            }, false.obs
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: ColorResources.secondaryTextColor,
                            minimumSize: const Size(400, 46),
                            padding: const EdgeInsets.all(8.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              controller.confirmPassword(
                                password: _newPasswordController.text,
                                current_password: _currentPasswordController.text,
                                password_confirmation: _confirmNewPasswordController.text,
                              );
                            }
                          },
                          child: const Text("Ubah Password"),
                        ),
                        const SizedBox(height: 20.0),
                        Center(
                            child: InkWell(
                                onTap: (){
                                  Get.toNamed(Routes.FORGOT_PASSWORD_PAGE);
                                },
                                child: Text('Lupa Password',style: boldTextStyle,))),
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
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }
}

Widget typePass(
    TextInputType keyboardType,
    String label,
    TextEditingController controller,
    String? Function(String?)? validator,
    RxBool obscureText,
    ) {
  return Obx(() => TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: obscureText.value,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.black,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          obscureText.value = !obscureText.value;
        },
        icon: Icon(obscureText.value ? Icons.visibility : Icons.visibility_off),
        color: Colors.black,
      ),
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.grey, // Label color is always grey
      ),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.normal),
    ),
    validator: validator,
  ));
}
