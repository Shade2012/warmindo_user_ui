import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

import '../utils/themes/buttonstyle_themes.dart';

class VoucherFrame extends StatelessWidget {
  const VoucherFrame({Key? key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          title: Text('Code Voucher'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
          floating: true,
          pinned: true,
        ),
      ],
      body: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  typeCode(
                    TextInputType.text,
                    'Code Voucher',
                    'Enter voucher code',
                    TextEditingController(),
                    (value) {
                      if (value.isEmpty) {
                        return 'Voucher code cannot be empty';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action to redeem voucher
                    },
                    style: redeembutton(),
                    child: Text('Redeem Voucher',style: whiteboldTextStyle15,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget typeCode(
    TextInputType keyboardType,
    String label,
    String hint,
    TextEditingController controller,
    String? Function(String)? validator,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          hintText: hint,
          labelText: label,
          labelStyle: boldTextStyle,
          hintStyle: GoogleFonts.oxygen(
            textStyle: TextStyle(color: primaryTextColor, fontSize: 12),
          ),
          errorText: validator != null ? validator(controller.text) : null,
        ),
      ),
    );
  }
}
