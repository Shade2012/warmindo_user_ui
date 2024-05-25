import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/detail-voucher-page/view/detail_voucher_page.dart';
import 'package:warmindo_user_ui/pages/voucher_page/controller/voucher_controller.dart';
import 'package:warmindo_user_ui/pages/voucher_page/shimmer/vouchershimmer.dart';
import 'package:warmindo_user_ui/routes/AppPages.dart';
import 'package:warmindo_user_ui/utils/themes/buttonstyle_themes.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/circleIcons.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import 'package:warmindo_user_ui/widget/voucher_bottom_sheet.dart';

class VoucherPage extends StatelessWidget {
  final VoucherController controller = Get.put(VoucherController());
   VoucherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: Text('Voucher'),
          centerTitle: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            width: screenWidth,
            height: screenHeight,
            child: Obx(()=> controller.isLoading.value?
                VoucherShimmer() :
            Column(
              children: [
                Container(
                  height: screenHeight * 0.8,
                  child: ListView.separated(
                    itemCount: controller.voucher.length,
                    itemBuilder: (BuildContext context, int index) {
                      final voucher = controller.voucher[index];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ]
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(voucher.description,style: boldTextStyle,),
                                SizedBox(height: 10,),
                                Divider(thickness: 1, color: Colors.grey,),
                                Row(
                                  children: [
                                    CircleIcon(
                                      iconData: FontAwesomeIcons.ticket,
                                    ),
                                    SizedBox(width: screenWidth / 30),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Code Voucher',
                                              style: blackvoucherTextStyle),
                                          Text(voucher.code, style: blackvoucherTextStyle),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    CircleIcon(iconData: Icons.date_range_sharp),
                                    SizedBox(width: screenWidth / 30),
                                    Text(DateFormat('yyyy-MM-dd').format(voucher.expired),
                                        style: blackvoucherTextStyle),
                                    Text(' || 1 x Penggunaan',
                                        style: blackvoucherTextStyle),
                                  ],
                                ),
                                SizedBox(height: 10,),

                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(DetailVoucherPage(voucher: voucher));
                              },
                              style:button_detail_voucher(),
                              child: Text('Detail Voucher',
                                  style: whitevoucherTextStyle),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 20,);
                    },


                  ),
                ),
                Container(
                  child: ElevatedButton(onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return VoucherFrame();
                      },
                    );
                  },style: button_reedem_voucher(), child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.ticket,color: Colors.black,),
                        SizedBox(width: 15),
                        Text('Punya Kode Voucher? Tukarkan disini!',style: vouchertextStyle,),
                      ],
                    ),
                  )),
                ),
              ],
            )

            ),
          ),
        ),
      ),
    );
  }
}
