import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/common/model/voucher_model.dart';

import '../../../widget/myCustomPopUp/myCustomPopup.dart';
import '../../../widget/voucher/voucher.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../../common/model/cartmodel.dart';

class VoucherController extends GetxController {
  final CartController controller = Get.put(CartController());
  RxList<Voucher> voucher = <Voucher>[].obs;
  Rx<Voucher?> appliedVoucher = Rx<Voucher?>(null);
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct();
    Future.delayed(Duration(seconds: 4),(){
      isLoading.value = false;
    });

  }
  void applyVoucher(Voucher voucher) {
    appliedVoucher.value = voucher;
  }

  void removeAppliedVoucher() {
    appliedVoucher.value = null;
  }
  void fetchProduct()  {
    DateTime now = DateTime.now();
    voucher.assignAll(voucherList.where((voucher) {
      // Check if the expiration date is after the current date
      return voucher.expired.isAfter(now);
    }).toList());
  }


  void showVoucher( BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => ApplyVoucher(),
    );
  }


}
