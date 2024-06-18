import 'package:get/get.dart';

import '../../utils/themes/image_themes.dart';

class CartItem {
  final int productId;
  final String productName;
  final String productImage;
  final int price;
  late RxInt quantity = 0.obs;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
  });
}

