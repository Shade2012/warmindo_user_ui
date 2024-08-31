import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText, hintStyle: hintSearchBarTextStyle,
          icon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
