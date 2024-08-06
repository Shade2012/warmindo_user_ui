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
  HomeSnack({Key? key, required this.menuItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (menuItem == null) {
      return Center(child: Text('Menu item not found'));
    }

    return   GestureDetector(
      onTap: () {
        Get.to(DetailMenuPage(
          menu: menuItem,
          isGuest: false,
        ));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        foregroundDecoration: scheduleController.jadwalElement[0].is_open
            ? null
            : BoxDecoration(
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
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: ColorResources.backgroundCardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(menuItem.nameMenu, style: regularInputTextStyle),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    menuItem.description,
                    maxLines: 2,
                    style: descriptionTextStyle,
                  ),
                  SizedBox(
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
                          Text(menuItem.ratings.toString(),
                              style: ratingTextStyle),
                        ],
                      ),
                      Spacer(),
                      Text(currencyFormat.format(menuItem.price),
                          style: priceTextStyle),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Stack(
              children: [
                Container(
                  width: 122, // Use the screen width
                  height: 104,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: (Radius.circular(20)),
                      bottomRight: (Radius.circular(20)),
                    ),
                    child: FadeInImage(
                      image: NetworkImage(menuItem.image),
                      fit: BoxFit.cover,
                      placeholder: AssetImage(Images.onboard2),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 8,
                  child: Container(
                    child: GestureDetector(
                      onTap: () {},
                      child: Cart(
                        context: context,
                        product: menuItem,
                      ),
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
