import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warmindo_user_ui/common/global_variables.dart';
import 'package:warmindo_user_ui/common/model/history2_model.dart';
import 'package:warmindo_user_ui/pages/history_page/controller/history_controller.dart';
import 'package:warmindo_user_ui/pages/menu_page/controller/menu_controller.dart';
import 'package:http/http.dart' as http;



class RatingController extends GetxController{
  late final SharedPreferences prefs;
  RxString token = ''.obs;
   MenuPageController menuPageController = Get.put(MenuPageController());
  HistoryController historyController = Get.put(HistoryController());
@override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }
  Future<void> addRating(int menuId, double rating,orderDetailId,Order2 order) async {


    token.value = prefs.getString('token') ?? '';
    String url = GlobalVariables.apiRating;
    Map<String, dynamic> data = {
      'menu_id': menuId,
      'rating': rating,
      'order_detail_id': orderDetailId,
    };
    try{
      final response = await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: jsonEncode(data));
      // Check if the response was successful
      if (response.statusCode == 200) {
        MenuList? menu = order.orderDetails.firstWhereOrNull((element) => element.menuId == menuId && element.orderDetailId == orderDetailId);
        if (menu != null) {
          menu.ratings?.value = rating;
          menuPageController.fetchProduct();
          print('Menu rating updated');
        }
        print(response.body);
        print('Rating submitted successfully');
      } else {
        // Handle server-side error
        print('Failed to submit rating. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle client-side error
      print('Error occurred while submitting rating: $e');
    }
  }

  // double getMeanRating(int menuId) {
  //   var menu = menuPageController.menuElement.firstWhere((element) => element.menuId == menuId);
  //   return menu.meanRating;
  // }


}
