import '../../utils/themes/image_themes.dart';

class CartItem {
  final int productId;
  final String productName;
  final String productImage;
  final int price;
  late int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
  });
}
// List<CartItem> cartList = [
//   CartItem(
//     productId: 1,
//     productName: 'Mie Ayam Penyet',
//     productImage: Images.onboard1,
//     price: 14000,
//     quantity: 3,
//   ),
//   CartItem(
//     productId: 2,
//     productName: 'Tubruk',
//     productImage: Images.eximagemenu,
//     price: 4000,
//     quantity: 1,
//   ),
// ];
