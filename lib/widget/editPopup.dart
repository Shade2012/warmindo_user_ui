import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/veritification_page/controller/veritification_controller.dart';
import '../utils/themes/buttonstyle_themes.dart';
import '../utils/themes/image_themes.dart';
import '../utils/themes/textstyle_themes.dart';

class EditPopup extends StatelessWidget {
  final TextEditingController ctrPhoneNumber = TextEditingController();
  final String phone_number;

  EditPopup({Key? key, required this.phone_number}) : super(key: key) {
    ctrPhoneNumber.text = phone_number;
  }

  @override
  Widget build(BuildContext context) {
    final VeritificationController veritificationController = Get.find();

    return AlertDialog(
      elevation: 0,
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(Images.batalask),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ctrPhoneNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Nomor Telepon',
                labelStyle: boldTextStyle,
                hintStyle: GoogleFonts.oxygen(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (ctrPhoneNumber.text.isEmpty) {
                    if(Get.isSnackbarOpen != true) {
                      Get.snackbar(
                        "Pesan",
                        "Nomor Hp Jangan Kosong",
                        backgroundColor: Colors.white,
                      );
                    }
                  } else {
                    veritificationController.editPhoneNumber(
                      phoneNumber: ctrPhoneNumber.text,
                    );
                  }
                },
                style: editPhoneNumber(),
                child: Text(
                  "Edit",
                  style: whiteboldTextStyle15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
