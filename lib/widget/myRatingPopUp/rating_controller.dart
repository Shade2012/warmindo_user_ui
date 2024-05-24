import 'package:get/get.dart';

import '../../pages/menu_page/model/menu_model.dart';

class RatingController extends GetxController{
  void addRating(int menuId, double rating) {
    final Menu menu = menuList[menuId];
    menu.ratings.add(rating);
  }

  double getMeanRating(int menuId) {
    var menu = menuList.firstWhere((element) => element.id == menuId);
    return menu.meanRating;
  }


}
