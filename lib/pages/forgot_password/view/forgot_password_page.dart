import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/pages/forgot_password/controller/forgot_password_controller.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:get/get.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgotPasswordPage({super.key});

  // Create a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: 'Lupa Password', style: headerRegularStyle),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                height: 300,
                child: Image.asset(Images.forgot_password_1, fit: BoxFit.cover),
              ),
              Text('Silahkan Isi Nomor HP anda yang sudah terdaftar di akun kami', style: boldTextStyle),
              const SizedBox(height: 10.0),
              Text("Nomor HP", style: regularInputTextStyle),
              const SizedBox(height: 10.0),
              Form(
                key: _formKey, // Assign the form key
                child: TextFormField(
                  controller: controller.phoneNumberController,
                  style: regularInputTextStyle,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 9) {
                      return 'Nomor Hp tidak valid';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Obx(()=> SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.sendOtp(phone_number: controller.phoneNumberController.text);
                      }
                    },
                    style: editPhoneNumber(),
                    child:controller.isLoading.value ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ) : Text('Kirim', style: whiteboldTextStyle15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
