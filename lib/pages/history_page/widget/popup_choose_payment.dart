import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../profile_page/controller/profile_controller.dart';
import 'package:get/get.dart';


class PopUpChoosePayment extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final HistoryController historyController = Get.put(HistoryController());
  int orderID;

  PopUpChoosePayment({super.key,required this.orderID});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        color:  Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if(historyController.isLoading.value == true){
                    return;
                  }else{
                    historyController.makePayment2(isTunai: false, orderid: orderID);
                  }

                },
                child: Column(
                  children: [
                    Ink(
                      child: Image.asset(
                        width: screenWidth / 7,
                        height: screenWidth /6.6,
                        Images.cashless,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                    Center(child: Text('Cashless',style: boldTextStyle,),)
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.3),
              GestureDetector(
                onTap: () {
                  if(historyController.isLoading.value == true){
                    return;
                  }else{
                    if(profileController.user_verified.value == '0'){
                      Get.snackbar('Pesan', 'User belum terverifikasi, anda bisa mendapatnya setelah memesan selama 15 kali atau meminta ke Warmindo');
                    }else{
                      historyController.makePayment2(isTunai: true, orderid: orderID);
                    }
                  }
                },
                child: Column(
                  children: [
                    Ink(
                      child: Image.asset(
                        width: screenWidth / 6,
                        height: screenWidth /6.6,
                        Images.tunai,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                    Center(child: Text('Tunai',style: boldTextStyle,),)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
