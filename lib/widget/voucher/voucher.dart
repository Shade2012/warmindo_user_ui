import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/voucher_page/controller/voucher_controller.dart';
import 'package:warmindo_user_ui/pages/voucher_page/model/voucher_model.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../../utils/themes/image_themes.dart';
import '../../utils/themes/textstyle_themes.dart';
class ApplyVoucher extends StatelessWidget {
  final VoucherController controller = Get.find<VoucherController>();

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      // Format the date using DateFormat
      return DateFormat('yyyy-MM-dd').format(date.toLocal());
    }
    return Container(
      padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height  / 1.7,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                     InkWell(
                       onTap: (){
                         Get.back();
                       },
                         child: Icon(Icons.arrow_back_ios,size: 15,)),
                   Text("Voucher",textAlign: TextAlign.center,style: boldTextStyle,),
                ],
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: (){
                Get.back();
                controller.removeAppliedVoucher();
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorResources.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Text("Hapus Voucher",style: whitevoucherTextStyle,textAlign: TextAlign.center,),
              ),

            ),
            Expanded(
              child:Obx(()=>
                 ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.voucher.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    Voucher voucher = controller.voucher[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(voucher.description),
                                Divider(),
                                Row(
                                  children: [
                                    Icon(FontAwesomeIcons.ticket),
                                    SizedBox(width: 10),
                                    Text('Code Voucher ${voucher.code}'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    SizedBox(width: 8),
                                    Text('${formatDate(voucher.expired)} || 1x Used'),
                                  ],
                                ),
                                SizedBox(height: 10),

                              ],
                            ),

                          ),
                        ),
                        InkWell(
                          onTap: (){
                            controller.applyVoucher(voucher);
                            Get.back();
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorResources.btnonboard2,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                            ),
                            child: Text("Pakai Voucher",style: whitevoucherTextStyle,textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

            ),
          ],
        ),
      );

  }
}
