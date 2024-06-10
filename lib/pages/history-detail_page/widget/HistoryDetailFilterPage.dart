import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/common/model/history.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/history_page/widget/order_box.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/appBar.dart';
import '../../../widget/shimmer/shimmer.dart';
import '../../history_page/controller/history_controller.dart';

class HistoryDetailFilterPage extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());
  Color selectedTextColor = Colors.white;
  Color dropdownTextColor = Colors.black;
  List<String> titles = <String>[
    'Terbaru',
    'Terlama',
  ];
  final String status;
  final List<Order> orders;

  HistoryDetailFilterPage({
    Key? key,
    required this.status,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: 'History $status',style: headerRegularStyle,),
      body: Container(
        padding: EdgeInsets.all(10),
        child:Obx(() {
          if (controller.isLoading.value) {
            return ListView.separated(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Skeleton(
                  width: double.infinity,
                  height: 170,
                  radius: 10,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20,);
              },
            );
          } else {
            return Column(
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CustomDropdown(
                    decoration: CustomDropdownDecoration(
                      listItemStyle: boldTextStyle,
                      listItemDecoration: ListItemDecoration(
                          selectedColor: Colors.black),
                    ),
                    initialItem: controller.selectedTimes.value,
                    items: titles,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.printOrdersLength();
                        controller.changeCategory(newValue);
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Obx(() =>
                      Text(controller.selectedTimes.value.toString(),
                        style: headerBold,),),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderBox(order: orders[index]);
                    },
                  ),
                ),
              ],
            );
          }
        }),

      ),
    );
  }
}
