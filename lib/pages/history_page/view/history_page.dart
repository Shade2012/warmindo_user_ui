import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/utils/themes/color_themes.dart';

import '../../../utils/themes/textstyle_themes.dart';


class HistoryPage extends GetView<HistoryController> {

  Color selectedTextColor = Colors.white;
  Color dropdownTextColor = Colors.black;
  List<String> titles = <String>[
    'Semua',
    'In Progress',
    'Selesai',
    'Pesanan Siap',
    'Menunggu Batal',
    'Batal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set shadow color here
                    spreadRadius: 1, // Set spread radius of the shadow
                    blurRadius: 3, // Set blur radius of the shadow
                    offset: Offset(0, 1), // Set offset of the shadow
                  ),
                ],
              ),
              child: Icon(Icons.keyboard_arrow_left_sharp),
            ),

          ),
        ),
        title: Text("History"),
        centerTitle: true,

      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 60,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.red,
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Obx(() => DropdownButtonFormField<String>(
                    value: controller.selectedCategory.value,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.changeCategory(newValue);
                      }
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: titles.expand<DropdownMenuItem<String>>((String value) {
                      final isLastItem = value == titles.last;
                      return [
                        DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: boldTextStyle,
                            selectionColor: Colors.white,
                          ),
                        ),
                        if (isLastItem)
                          DropdownMenuItem<String>(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0),
                            ),
                            value: null,
                            enabled: false,
                          )
                        else
                          DropdownMenuItem<String>(
                            child: Divider(
                              color: Colors.black,
                              height: 1,
                            ),
                            value: null,
                            enabled: false,
                          ),
                      ];
                    }).toList(),
                  )),
                ),
              ],
            ),

          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: getCategoryItemCount(controller.selectedCategory.value),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${controller.selectedCategory.value} $index'),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  int getCategoryItemCount(String category) {
    switch (category) {
      case 'Semua':
        return 5;
      case 'Selesai':
        return 3;
      case 'Pesanan Siap':
        return 4;
      case 'Menunggu Batal':
        return 2;
      case 'Batal':
        return 6;
      default:
        return 0;
    }
  }
}

