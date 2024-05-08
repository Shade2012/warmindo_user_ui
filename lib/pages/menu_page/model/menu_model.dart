import 'package:warmindo_user_ui/utils/themes/image_themes.dart';

class Menu {
  final int id;
  final String name;
  final String category;
  final int price;
  final String description;
  final String imagePath;
  int quantity;

  Menu({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imagePath,
    this.quantity = 1
  });
}

List<Menu> menuList = [

  Menu(
    id: 1,
    name: 'Tubruk',
    category: 'Minuman',
    price: 4000,
    description: 'bubuk kopi dengan air panas langsung dalam gelas atau cangkir.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 2,
    name: 'Mie Ayam Penyet',
    category: 'Makanan',
    price: 14000,
    description: 'Ayam goreng dengan sambal penyet dan mi indomie.',
    imagePath: Images.onboard1,
  ),
  Menu(
    id: 3,
    name: 'Nasi Goreng',
    category: 'Makanan',
    price: 12000,
    description: 'Nasi goreng spesial dengan campuran bumbu rempah pilihan.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 4,
    name: 'Ayam Goreng',
    category: 'Makanan',
    price: 12000,
    description: 'Ayam goreng yang gurih dan renyah dengan bumbu khas.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 5,
    name: 'Ayam Serundeng',
    category: 'Makanan',
    price: 10000,
    description: 'Ayam goreng dengan taburan serundeng yang lezat.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 6,
    name: 'Mie Goreng',
    category: 'Makanan',
    price: 4500,
    description: 'Mie goreng dengan saus pedas dan irisan sayuran segar.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 7,
    name: 'Mie Ayam Penyet',
    category: 'Makanan',
    price: 13000,
    description: 'Mie ayam dengan bumbu pedas dan daging ayam yang empuk.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 8,
    name: 'Nutrisari Jeruk',
    category: 'Minuman',
    price: 3000,
    description: 'Minuman rasa jeruk yang menyegarkan',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 9,
    name: 'Good Day Freeze',
    category: 'Minuman',
    price: 4000,
    description: 'Minuman kopi dingin yang menyegarkan.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 10,
    name: 'Good Day Capucino',
    category: 'Minuman',
    price: 4000,
    description: 'Minuman capucino dengan cita rasa khas.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 11,
    name: 'Es Teh',
    category: 'Minuman',
    price: 3000,
    description: 'Es teh dengan tambahan es batu yang segar.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 12,
    name: 'Mendoan',
    category: 'Snack',
    price: 1000,
    description: 'Gorengan berbahan dasar tepung terigu yang renyah dan gurih.',
    imagePath: Images.eximagemenu,
  ),
  Menu(
    id: 13,
    name: 'Bakwan',
    category: 'Snack',
    price: 1000,
    description: 'Gorengan berisi campuran sayuran dan tepung yang gurih.',
    imagePath: Images.eximagemenu,
  ),
];
