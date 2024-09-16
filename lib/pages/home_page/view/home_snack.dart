import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common/model/menu_list_API_model.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../../widget/cart.dart';
import '../../detail-menu_page/view/detail_menu_page.dart';
import '../controller/home_controller.dart';
import '../controller/schedule_controller.dart';

class HomeSnack extends StatelessWidget {
  final MenuList menuItem;
  final currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final HomeController controller = Get.put(HomeController());
  final scheduleController = Get.find<ScheduleController>();
  HomeSnack({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    if (menuItem == null) {
      return const Center(child: Text('Menu item not found'));
    }

    return   GestureDetector(
      onTap: () {
        Get.to(DetailMenuPage(
          menu: menuItem,
          isGuest: false,
        ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        foregroundDecoration: (menuItem.stock!.value > 1 && scheduleController.jadwalElement[0].is_open && menuItem.statusMenu != '0')
            ? null
            : const BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: ColorResources.backgroundCardColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(menuItem.nameMenu, style: regularInputTextStyle),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    menuItem.description,
                    maxLines: 2,
                    style: descriptionTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color:
                            scheduleController.jadwalElement[0].is_open
                                ? Colors.orange
                                : Colors.grey,
                            size: 20,
                          ),
                          Text(menuItem.rating.toString(),
                              style: ratingTextStyle),
                        ],
                      ),
                      const Spacer(),
                      Text(currencyFormat.format(menuItem.price),
                          style: priceTextStyle),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                SizedBox(
                  width: 122, // Use the screen width
                  height: 104,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: (Radius.circular(20)),
                      bottomRight: (Radius.circular(20)),
                    ),
                    child: FadeInImage(
                      image: NetworkImage(menuItem.image),
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(Images.onboard2),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {},
                    child: Cart(
                      context: context,
                      product: menuItem,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
