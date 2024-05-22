import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/pages/menu_page/model/menu_model.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../../../widget/appBar.dart';
import '../../../widget/myCustomPopUp/myPopup_controller.dart';

class DetailMenuPage extends StatelessWidget {
  final Menu menu;
  DetailMenuPage({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popUpcontroller = Get.put(MyCustomPopUpController());
    final currencyFormat =
    NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppbarCustom(
        title: 'Details',
        style: headerRegularStyle,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        menu.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(menu.name, style: boldTextStyle2,),
                  Text(menu.category, style: regulargreyText,),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.star_rounded, color: Colors.orange, size: 23,),
                          Text('4.6', style: descriptionratingTextStyle),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  Text('Deskripsi', style: boldTextStyle,),
                  Text(menu.description, style: onboardingskip,)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: screenWidth,
        height: 100,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Harga', style: onboardingskip,),
                Text(
                  currencyFormat.format(menu.price),
                  style: appBarTextStyle,
                ),
              ],
            ),

            InkWell(
              onTap: () {
                popUpcontroller.showCustomModalForItem(menu, context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text("Tambah", style: whiteregulerTextStyle15,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
