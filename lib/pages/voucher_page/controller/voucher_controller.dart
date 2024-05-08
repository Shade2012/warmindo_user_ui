import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warmindo_user_ui/pages/voucher_page/model/voucher_model.dart';

import '../../../widget/myCustomPopUp/myCustomPopup.dart';
import '../../../widget/voucher/voucher.dart';
import '../../cart_page/controller/cart_controller.dart';
import '../../cart_page/model/cartmodel.dart';

class VoucherController extends GetxController {
  final CartController controller = Get.put(CartController());
  RxList<Voucher> voucher = <Voucher>[].obs;
  Rx<Voucher?> appliedVoucher = Rx<Voucher?>(null);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProduct();

  }
  void applyVoucher(Voucher voucher) {
    appliedVoucher.value = voucher;
  }

  void removeAppliedVoucher() {
    appliedVoucher.value = null;
  }
  void fetchProduct()  {
    voucher.assignAll(voucherList);
  }
  void showVoucher( BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => ApplyVoucher(),
    );
  }


}
