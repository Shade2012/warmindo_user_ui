import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../controller/pembayaran_complate_controller.dart';
class PembayaranComplate extends StatelessWidget {
  final controller = Get.put(PembayaranComplateController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.offNamed(Routes.BOTTOM_NAVBAR);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ColorResources.btnonboard2,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text("Kembali",style: categoryMenuTextStyle,),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight / 4.5,
                  ),
                  Center(
                    child: Image.asset(Images.complete),
                  ),
                  Center(child: Text("Order Berhasil",style: headerboldverifyTextStyle,textAlign: TextAlign.center,)),
                  Center(child: Text("Silakan tunggu konfimasi dari kasir",style: regulargreyText,textAlign: TextAlign.center,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

