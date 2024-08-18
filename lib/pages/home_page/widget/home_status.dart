import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../../../utils/themes/textstyle_themes.dart';
import '../controller/home_controller.dart';
import 'package:get/get.dart';
class HomeStatus extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
   HomeStatus({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:controller.scheduleController.jadwalElement[0].is_open ? ColorResources.open : ColorResources.close,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Status Toko ',style: boldphoneNumberRegularTextStyle,),
              Text(
                controller.scheduleController.jadwalElement[0].is_open ? 'Buka' : 'Tutup',
                style: boldphoneNumberTextStyle.copyWith(
                  color: controller.scheduleController.jadwalElement[0].is_open ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          Visibility(
              visible: controller.scheduleController.jadwalElement[0].temporary_closure_duration != 0,
              child: Text('Toko Tutup Sementara',style: boldphoneNumberTextStyle,)),
          SizedBox(height: 15,),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Jam Buka : ',
                      style: boldphoneNumberRegularTextStyle,
                    ),
                    TextSpan(
                      text: controller.scheduleController.jadwalElement[0].start_time,
                      style: boldphoneNumberTextStyle
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Jam Tutup : ',
                      style: boldphoneNumberRegularTextStyle,
                    ),
                    TextSpan(
                        text: controller.scheduleController.jadwalElement[0].end_time,
                        style: boldphoneNumberTextStyle
                    ),
                  ],
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
