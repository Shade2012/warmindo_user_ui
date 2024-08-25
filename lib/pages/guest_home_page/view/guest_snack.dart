import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../common/model/menu_list_API_model.dart';
import '../../../utils/themes/color_themes.dart';
import '../../../utils/themes/image_themes.dart';
import '../../../utils/themes/textstyle_themes.dart';
import '../../detail-menu_page/view/detail_menu_page.dart';
import '../../home_page/controller/schedule_controller.dart';
import '../controller/guest_home_controller.dart';
class GuestSnack extends StatelessWidget {
  final MenuList menuItem;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final GuestHomeController controller = Get.put(GuestHomeController());
  final scheduleController = Get.find<ScheduleController>();
   GuestSnack({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    if (menuItem == null) {
      return const Center(child: Text('Menu item not found'));
    }
    return  GestureDetector(
      onTap: (){
        Get.to(DetailMenuPage(menu: menuItem, isGuest: true, ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        foregroundDecoration: scheduleController.jadwalElement[0].is_open
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
                  const SizedBox(height: 10,),
                  Text(menuItem.nameMenu, style: regularInputTextStyle),
                  const SizedBox(height: 3,),
                  Text(
                    menuItem.description,maxLines: 2,overflow: TextOverflow.ellipsis,
                    style: descriptionTextStyle,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.orange, size: 20,),
                          Text(menuItem.rating.toString(), style: ratingTextStyle),
                        ],
                      ),
                      const Spacer(),
                      Text(currencyFormat.format(menuItem.price), style: priceTextStyle),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
            const SizedBox(width: 10,),
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

              ],
            ),

          ],
        ),
      ),
    );
  }
}
