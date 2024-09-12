import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

// Color getLabelColor(String status, String cancelMethod) {
//   switch (status.toLowerCase()) {
//     case 'selesai':
//       return Colors.green;
//     case 'batal':
//       return Colors.green;
//     case 'menunggu batal' :
//     case 'pesanan siap' :
//       return Colors.white60;
//     case 'menunggu pembayaran' :
//       return Colors.black;
//     default:
//       return Colors.red; // Default to red for other statuses
//   }
// }
Color getLabelColor(String status, String cancelMethod) {
  if (status.toLowerCase() == 'selesai' || status.toLowerCase() == 'batal') {
    return Colors.green;
  }else if (status.toLowerCase() == 'menunggu batal' || status.toLowerCase() == 'pesanan siap' || status.toLowerCase() == 'sedang diproses' || status.toLowerCase() == 'sedang diantar') {
    return Colors.white60;
  } else if (status.toLowerCase() == 'menunggu batal' && cancelMethod == '') {
    return Colors.red;
  }else if (status.toLowerCase() == 'menunggu pengembalian dana') {
    return Colors.white60;
  }  else if (status.toLowerCase() == 'menunggu pembayaran' ) {
    return Colors.black;
  }else {
    return Colors.red; // Default to red for other statuses
  }
}
Color getColorVerify(bool status){
if(status == true){
return Colors.blue;
}else{
  return Colors.grey;
}
}

// Create a function to generate dynamic button style
ButtonStyle dynamicButtonStyle(String status,String cancelMethod) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(getLabelColor(status,cancelMethod)),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle verifyOTPStyle(bool status) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(getColorVerify(status)),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle authLoginRegisterButtonStyle() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(ColorResources.btnonboard),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle redeembutton() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
ButtonStyle black_secWhite() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    minimumSize: WidgetStateProperty.all<Size>(const Size(211,46)),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.all(10.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
ButtonStyle verificationButton() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle redeembutton2() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle editPhoneNumber() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.only(top: 15, bottom: 15),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

ButtonStyle button_no() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),


    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle button_cancel() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),

    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
ButtonStyle button_detail_voucher() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(ColorResources.voucherbtnDetail),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
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
    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(0),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
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
    backgroundColor: WidgetStateProperty.all<Color>(ColorResources.btnonboard2),
    elevation: WidgetStateProperty.all<double>(0),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
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
    backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(0),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
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
