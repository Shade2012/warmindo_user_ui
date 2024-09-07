import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/global_variables.dart';
import '../../history_page/controller/history_controller.dart';
class PembatalanController extends GetxController {
  final HistoryController historyController = Get.put(HistoryController());
  late final TextEditingController ctrAlasanBatal = TextEditingController(text: 'Alasan Batal :');
  late final SharedPreferences prefs;
  final NoRek = TextEditingController();
  final RxString noRekText = ''.obs;
  var selectedBanks = 'Belum Dipilih'.obs;
  String token = '';
  RxBool isLoadingButton = false.obs;

  @override
  void onInit() async  {
    // TODO: implement onInit
    super.onInit();
    NoRek.addListener(() {
      noRekText.value = NoRek.text;
    });

    prefs = await SharedPreferences.getInstance();

  }
  @override
  void onClose() {
    NoRek.dispose();  // Remember to dispose of the controller
    super.onClose();
  }
  final List<String> BankList = <String>[
    'Belum Dipilih',
    'BCA',
    'BRI',
    'BNI',
    'BSI',
    'Mandiri'
  ];

  void changeBank(String Banks) {
    selectedBanks.value = Banks;
  }
  Future<void> postCancelOrder({required String orderid, required int noRek, required String cancelMethod, required String alasanBatal}) async {
    token = prefs.getString('token') ?? '';
    final body = {
      "no_rekening": noRek,
      "cancel_method": cancelMethod,
      "reason_cancel": alasanBatal,
    };
    final id = int.tryParse(orderid);
    try {
      isLoadingButton.value = true; // Set loading state to true

      final response = await http.post(
        Uri.parse('${GlobalVariables.apiCancelOrder}$orderid'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final updatedOrder = historyController.orders2.firstWhere((element) => element.id == id);
        updatedOrder.status.value = updatedOrder.paymentMethod!.toLowerCase() == 'tunai' ? 'batal' :'menunggu pengembalian dana'; // Set the new status value
        updatedOrder.alasan_batal?.value = alasanBatal; // Set the new cancel reason
        updatedOrder.noRekening?.value = noRek.toString();
        updatedOrder.cancelMethod?.value = cancelMethod;
        await historyController.fetchHistory();
        historyController.orders2.refresh(); // Refresh the order list to reflect the changes
        Get.back(); // Go back to the previous screen
      } else {
        // Handle other status codes if needed
        print('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoadingButton.value = false; // Reset loading state
    }
  }

  int calculatePriceCancel(String paymentMethod, int totalPrice) {
    double percentage = 0.0;

    // Determine the percentage reduction based on the payment method
    switch (paymentMethod.toLowerCase()) {
      case 'ovo':
        percentage = 1.5;
        break;
      case 'dana':
        percentage = 1.5;
        break;
      case 'jeniuspay':
        percentage = 2.0;
        break;
      case 'shopeepay':
        percentage = 1.8;
        break;
      case 'linkaja':
        percentage = 1.5;
        break;
      case 'qris':
        percentage = 0.63;
        break;
      default:
      // If payment method is not found, no discount is applied
        percentage = 0.0;
        break;
    }

    // Calculate the reduced price
    double reductionAmount = totalPrice * (percentage / 100);
    int finalPrice = (totalPrice - reductionAmount).round();

    return finalPrice;
  }

}
