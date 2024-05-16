import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../pages/history_page/model/history.dart';
import '../utils/themes/color_themes.dart';
class OrderBox extends StatelessWidget {
  OrderBox({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  Color _getLabelColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return ColorResources.labelcomplete;
      case 'in progress':
        return ColorResources.labelinprogg;
      case 'menunggu':
        return ColorResources.labelcancel;
      case 'batal':
        return ColorResources.labelcancel;
      case 'pesanan siap':
        return ColorResources.labelcomplete;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    int totalPrice = 0;
    int totalQuantity = 0;

    for (Menu menu in order.menus) {
      totalPrice += menu.price * menu.quantity;
      totalQuantity += menu.quantity;
    }

    final labelColor = _getLabelColor(order.status);

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(2.0, 5.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.status, style: TextStyle(
                    fontFamily: GoogleFonts.oxygen().fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: labelColor
                ),),
                Text(currencyFormat.format(totalPrice),style: boldTextStyle,)
              ],
            ),
            SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              itemCount: order.menus.length,
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: screenWidth / 4,
                      height: screenHeight * 0.11,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(order.menus[index].imagePath, fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(width: 10), // Add space between image and text
                    Container(
                      height:screenHeight * 0.11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(order.menus[index].name, style: boldTextStyle,),
                          Text('(${order.menus[index].quantity} Items)'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }

}

