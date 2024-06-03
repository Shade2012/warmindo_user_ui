import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../routes/AppPages.dart';
import '../../utils/themes/image_themes.dart';
class GuestReusableCard extends StatelessWidget {
  const GuestReusableCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))
        ),
        height:290,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Center(

                    child: Image.asset(Images.haveaccount),
                  ),
                  SizedBox(height: 10,),
                  Text("Sudah memiliki akun? ayok daftarkan akun anda untuk pemesanan makanan dan minuman dari Warmindo",style: boldTextStyle,),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                    child:
                    ElevatedButton(onPressed: (){
                      Get.offAllNamed(Routes.REGISTER_PAGE);
                    },style: button_register(),
                        child:
                        Padding(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                          child: Text("Register",style: onboardingButtonTextStyle,),
                            // editProfileTextStyle
                        )
                    )
                ),
                SizedBox(width: 5,),
                Expanded(
                    child:
                    ElevatedButton(onPressed: (){
                      Get.offAllNamed(Routes.LOGIN_PAGE);
                    },style: button_login(),
                        child:
                        Padding(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                          child: Text("Login",style:editProfileTextStyle,),

                        )
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
