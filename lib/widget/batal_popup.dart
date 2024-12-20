import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/widget/ReusableTextBox.dart';
import '../common/model/history2_model.dart';
import '../pages/history_page/controller/history_controller.dart';
import '../utils/themes/buttonstyle_themes.dart';
import '../utils/themes/textstyle_themes.dart';
class BatalPopup extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());
  final TextEditingController ctrAlasan = TextEditingController();
  final Order2 order;

  BatalPopup({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
            const SizedBox(height: 20,),
            Text("Apakah kamu yakin melakukan pembatalan?",style: boldTextStyle,),
            const SizedBox(height: 20,),
            ReusableTextBox(title: 'Alasan', controller: ctrAlasan,),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    Get.back();
                  }, style: button_no(),child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),

                    child: Text("Tidak",style: boldTextStyle,),
                  )),
                ),
                const SizedBox( width: 10,),
                Expanded(
                  child: ElevatedButton(onPressed: (){
                    if(ctrAlasan.text.isEmpty){
                      if(Get.isSnackbarOpen != true) {
                        Get.snackbar("Pesan",
                          "Beri alasan terlebih dahulu kenapa membatalkan pesanan",
                          backgroundColor: Colors.white,);
                      }
                    } else {
                      order.status.value = "menunggu batal";
                      order.alasan_batal!.value = ctrAlasan.text;
                      historyController.orders2.refresh();
                      Get.back();
                    }
                  },style: button_cancel(), child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),

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

