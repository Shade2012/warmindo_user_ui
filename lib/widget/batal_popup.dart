import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';

import '../pages/history_page/model/history.dart';
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
            TextField(
              controller: ctrAlasan,
              maxLines: null,
              minLines: 3,
              decoration: InputDecoration(
                labelText: 'Alasan:',
                labelStyle: boldTextStyle,
                focusColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2), // Adjust the border color and width
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2), // Adjust the border color and width
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2), // Adjust the border color and width
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: (){
                  Get.back();
                }, style: button_no(),child: Container(

                  padding: const EdgeInsets.all(15),
                  child: Text("Tidak",style: boldTextStyle,),
                )),
                ElevatedButton(onPressed: (){
                  if(ctrAlasan.text.isEmpty){
                  Get.snackbar("Pesan", "Beri alasan terlebih dahulu kenapa membatalkan pesanan",backgroundColor: Colors.white,);
                  } else {
                    order.status.value = "Menunggu Batal";
                    Get.back();
                  }
                },style: button_cancel(), child: Container(

                  padding: const EdgeInsets.all(15),
                  child: Text("Batalkan",style: whiteboldTextStyle15,),
                ))
              ],
            )
          ],
        ),
      ),

    );
  }
}

