import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

Color getLabelColor(String status) {
  switch (status.toLowerCase()) {
    case 'selesai':
      return Colors.green;
    case 'batal':
      return Colors.green;
    case 'menunggu batal' :
    case 'pesanan siap' :
      return Colors.white60;
    default:
      return Colors.red; // Default to red for other statuses
  }
}
Color getColorVerify(bool status) {
if(status == true){
return Colors.blue;
}else{
  return Colors.grey;
}
}

// Create a function to generate dynamic button style
ButtonStyle dynamicButtonStyle(String status) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(getLabelColor(status)),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle verifyOTPStyle(bool status) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(getColorVerify(status)),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle authLoginRegisterButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(ColorResources.btnonboard),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle redeembutton() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle redeembutton2() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle button_no() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),


    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle button_cancel() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),

    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle button_detail_voucher() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(ColorResources.voucherbtnDetail),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),

      ),
    ),
  );
}
ButtonStyle button_reedem_voucher() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    elevation: MaterialStateProperty.all<double>(0),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
        Radius.circular(10.0),
        ),
        side: BorderSide(
          color: Colors.grey, // Set the border color here
          // Set the border width here
        ),
      ),
    ),
  );
}

ButtonStyle button_login() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(ColorResources.btnonboard2),
    elevation: MaterialStateProperty.all<double>(0),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        side: BorderSide(
          color: ColorResources.btnonboard2,
        ),
      ),
    ),
  );
}

ButtonStyle button_register() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    elevation: MaterialStateProperty.all<double>(0),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        side: BorderSide(
          color: ColorResources.btnonboard2, // Set the border color here
          // Set the border width here
        ),
      ),
    ),
  );
}
