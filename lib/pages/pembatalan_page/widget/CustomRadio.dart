import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadio extends StatelessWidget {
  RxInt value;
  RxInt groupValue;
  Icon? icons;
  Icon? selectIcons;
  void Function(RxInt?)? onChanged;

  CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.icons,
    this.selectIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool selected = value.value != groupValue.value;
      return InkWell(
        onTap: () {
          if (selected) {
            onChanged!(value);
          }
        },
        child: value.value == groupValue.value ? selectIcons : icons,
      );
    });
  }
}
