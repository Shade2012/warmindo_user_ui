import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class ReusableTextBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  ReusableTextBox({required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: 5,
          style: regulargreyText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.0, bottom: 84), // Adjust padding
              child: Text('${title}: ',
                style:boldgreyText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
