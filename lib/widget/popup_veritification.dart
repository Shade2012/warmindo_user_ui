import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class VerificationStatusPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // Background color
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cara Dapat",
                    style: boldTextStyle, // Text color
                  ),
                  Text('Cara mendapatkan centang verifikasi, itu ada 2 cara'),
                  Text('1. Dari System minimal membeli 15 kali,'),
                  Text('2. Dari admin meminta ke pihak warmindo untuk mendapatkan centangnya',maxLines: 3,),
                  SizedBox(height: 10,),
                  Text(
                    "Keuntungan",
                    style: boldTextStyle, // Text color
                  ),
                  Text("Dapat membuka metode pembayaran dengan uang saat mengambil pesanan",style: regulerinfotext,),
                  SizedBox(height: 10,),
                  Text("Tanda Verifikasi: ",style: regulerinfotext,),
                  SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(Images.exampleverfication2)),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "OK",
            style: boldTextStyle, // Button text color
          ),
        ),
      ],
    );
  }
}

