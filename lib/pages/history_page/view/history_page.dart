// In HistoryPage

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/widget/order_box.dart';
import 'package:warmindo_user_ui/widget/shimmer/shimmer.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../controller/history_controller.dart';
import '../../../common/model/history.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());
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
      appBar: AppbarCustom(title: 'History',style: headerRegularStyle,),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Obx(() {
          if(controller.isLoading.value == true){
            return
              ListView.separated(
                itemCount: 4,
                  itemBuilder: (context,index){
                  return Skeleton(
                    width: double.infinity,
                    height: 170,radius: 10,
                  );
            }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20,);
              },);
          }else{
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Obx(() =>
                        CustomDropdown(
                          decoration: CustomDropdownDecoration(
                            listItemStyle: boldTextStyle,
                            listItemDecoration: ListItemDecoration(
                                selectedColor: Colors.black),
                          ),
                          initialItem: controller.selectedCategory.value,
                          items: titles,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.printOrdersLength();
                              controller.changeCategory(newValue);
                            }
                          },
                        )),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Obx(() =>
                        Text(controller.selectedCategory.value.toString(),
                          style: headerBold,),)),
                Flexible(
                  child: Obx(() =>
                      ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        primary: false,
                        itemCount: controller
                            .filteredHistory()
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          final order = controller.filteredHistory()[index];
                          return OrderBox(
                            order: order,
                          );
                        },
                      )),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
