import 'package:warmindo_user_ui/utils/themes/image_themes.dart';
class Voucher {
  final int id;
  final String name;
  final String imagePath;
  final int discount;
  final String code;
  final DateTime expired; // Store expiration date as DateTime
  final String description;

  int quantity;

  Voucher({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.discount,
    required this.code,
    required this.expired, // Change type to DateTime
    required this.description,
    this.quantity = 1
  });
}


List<Voucher> voucherList = [
  Voucher(
      id: 1,
      name: "diskon15k",
      imagePath: Images.promo2,
      discount: 15000,
      code: "0LER25C",
      expired: DateTime(2024, 5, 30), // Use DateTime object
      description: "Nikmati Kelezatan Tanpa Batas dengan Diskon 15.000 Ayo, Segera Pesan dan Rasakan Sensasi Minum yang Luar Biasa!"
  ),
  Voucher(
      id: 2,
      name: "diskon10k",
      imagePath: Images.promo1,
      discount: 10000,
      code: "OSL2P23",
      expired: DateTime(2024, 5, 30), // Use DateTime object
      description: "Nikmati Kelezatan Tanpa Batas dengan Diskon 10.000 Ayo, Segera Pesan dan Rasakan Sensasi Minum yang Luar Biasa!"
  )
];

