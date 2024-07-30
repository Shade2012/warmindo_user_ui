import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:warmindo_user_ui/pages/login_page/controller/login_controller.dart';
import 'package:warmindo_user_ui/pages/register_page/controller/register_controller.dart';
import 'package:warmindo_user_ui/pages/verification_profile_page/controller/verification_profile_controller.dart';

import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/editPopup.dart';
import 'package:warmindo_user_ui/widget/otp_textfield.dart';
import 'package:flutter/gestures.dart';
import '../../../utils/themes/buttonstyle_themes.dart';
import '../../../utils/themes/color_themes.dart';
import '../../edit-profile/controller/edit_profile_controller.dart';
import '../widget/pop_up_verification.dart';

class VerificationProfilePage extends GetView<VerificationProfileController> {
  final EditProfileController profileController = Get.put(EditProfileController());
  final RxBool isEdit;
  VerificationProfilePage({required this.isEdit});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              height:screenHeight,  // Ensure the container takes full screen height
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Obx((){
                  if(!controller.isConnected.value){
                    return Center(
                      child: Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.2),
                        child: Text(
                          'Tidak ada koneksi internet mohon check koneksi internet anda',
                          style: boldTextStyle,textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }else{
                  return Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        InkWell(
                          child: Ink(
                              child: Icon(Icons.arrow_back_ios_new)),
                          onTap: (){
                            Get.back();
                          },
                        ),
                        SizedBox(height: screenHeight * 0.26,),
                        Column(
                          children: [
                            SizedBox(),
                            Obx((){
                              if(isEdit.value == true){
                                return Text(
                                  'Ubah Nomor HP',
                                  style: headerboldverifyTextStyle,
                                  textAlign: TextAlign.start,
                                );
                              }else {
                                return Text(
                                  'Tambahkan Nomor HP',
                                  style: headerboldverifyTextStyle,
                                  textAlign: TextAlign.start,
                                );
                              }
                            }),
                            Divider(),
                            SizedBox(height: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text('Nomer Hp'),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  controller: controller.phoneNumberController,
                                  style: regularInputTextStyle,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0), // Adjust padding here
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.length < 11) {
                                      return "Nomor Hp tidak valid";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Container(
                            width:screenWidth,
                              child: ElevatedButton(
                                  onPressed: (){
                                    if(controller.formKey.currentState!.validate()){
                                      controller.editPhoneNumber(phone_number: controller.phoneNumberController.text,context: context);
                                    }else{
                                      return null;
                                    }
                              },style: verificationButton(), child: Text('Konfirmasi',style: whiteboldTextStyle15,))) ,
                        )
                      ],
                    ),
                  );}
                  },
                ),
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
                  child: CircularProgressIndicator(color: Colors.blue),
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
