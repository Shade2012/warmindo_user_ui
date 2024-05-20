import 'package:flutter/material.dart';

Color _getLabelColor(String status) {
  switch (status.toLowerCase()) {
    case 'selesai':
      return Colors.green;
    case 'batal':
      return Colors.green;
    case 'menunggu batal':
      return Colors.white60;
    default:
      return Colors.red; // Default to red for other statuses
  }
}

// Create a function to generate dynamic button style
ButtonStyle dynamicButtonStyle(String status) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(_getLabelColor(status)),
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
