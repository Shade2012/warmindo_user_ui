import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class ReusableTextBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  ReusableTextBox({required this.title, required this.controller}) {
    controller.addListener(() {
      if (controller.text.length < title.length) {
        controller.text = title;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      } else if (!controller.text.startsWith(title)) {
        String newText = title + controller.text.replaceFirst(title, '');
        controller.text = newText;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: newText.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          child: TextFormField(
            controller: controller,
            maxLines: 5,
            style: regulargreyText,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
