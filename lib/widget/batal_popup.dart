import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/widget/ReusableTextBox.dart';

import '../common/model/history.dart';
import '../utils/themes/buttonstyle_themes.dart';
import '../utils/themes/textstyle_themes.dart';
class BatalPopup extends StatelessWidget {
  final TextEditingController ctrAlasan = TextEditingController();
  final Order order;
  BatalPopup({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      elevation: 0,
      contentPadding: EdgeInsets.all(20),

      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(Images.batalask),
            ),
            SizedBox(height: 20,),
            Text("Apakah kamu yakin melakukan pembatalan?",style: boldTextStyle,),
            SizedBox(height: 20,),
            ReusableTextBox(title: 'Alasan', controller: ctrAlasan,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Get.back();
                  }, style: button_no(),child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),

                    child: Text("Tidak",style: boldTextStyle,),
                  )),
                ),
                SizedBox( width: 10,),
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    if(ctrAlasan.text.isEmpty){
                    Get.snackbar("Pesan", "Beri alasan terlebih dahulu kenapa membatalkan pesanan",backgroundColor: Colors.white,);
                    } else {
                      order.status.value = "Menunggu Batal";
                      order.alasan_batal!.value = '${ctrAlasan.text}';
                      Get.back();
                    }
                  },style: button_cancel(), child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),

                    child: Text("Batalkan",style: whiteboldTextStyle15,),
                  )),
                )
              ],
            )
          ],
        ),
      ),

    );
  }
}

