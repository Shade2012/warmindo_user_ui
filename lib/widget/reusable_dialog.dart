import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class ReusableDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final Function onCancelPressed;
  final Function onConfirmPressed;
  final Color cancelButtonColor;
  final Color confirmButtonColor;
  final Color cancelButtonTextColor;
  final Color confirmButtonTextColor;
  final Widget? dialogImage;

  ReusableDialog({
    required this.title,
    required this.content,
    required this.cancelText,
    required this.confirmText,
    required this.onCancelPressed,
    required this.onConfirmPressed,
    this.cancelButtonColor = Colors.red,
    this.confirmButtonColor = Colors.green,
    this.cancelButtonTextColor = Colors.white,
    this.confirmButtonTextColor = Colors.white,
    this.dialogImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorResources.backgroundColor,
      title: Text(
        title,
        style: titleDialogButtonTextStyle,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dialogImage != null) dialogImage!,
          SizedBox(height: dialogImage != null ? 20 : 0),
          Text(
            content,
            style: contentDialogButtonTextStyle,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onCancelPressed as void Function()?,
          style: TextButton.styleFrom(
            minimumSize: Size(120, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(color: Colors.white),
            ),
            backgroundColor: cancelButtonColor,
            foregroundColor: cancelButtonTextColor,
          ),
          child: Text(
            cancelText,
            style: dialogButtonTextStyle,
          ),
        ),
        TextButton(
          onPressed: onConfirmPressed as void Function()?,
          style: TextButton.styleFrom(
            minimumSize: Size(120, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
              side: BorderSide(color: Colors.white),
            ),
            backgroundColor: confirmButtonColor,
            foregroundColor: confirmButtonTextColor,
          ),
          child: Text(
            confirmText,
            style: dialogButtonTextStyle,
          ),
        ),
      ],
    );
  }
}
