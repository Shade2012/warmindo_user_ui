import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/model/menu_list_API_model.dart';
import '../../pages/menu_page/controller/menu_controller.dart';
import '../../utils/themes/textstyle_themes.dart';
import '../dashed_divider.dart';
import 'menucard_widget.dart';
class MinumanMenu extends StatelessWidget {
  final List<MenuList> menuList;
  final bool isGuest;
  MinumanMenu({Key? key, required this.menuList, required this.isGuest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return  Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //KOPI
              Text('Kopi',style: onboardingHeaderTextStyle,),
              MenuCategory(
                menuList: menuList,
                context: context,
                isGuest: isGuest,
                secondCategory: 'Kopi',
              ),
              //TEH
              Text('Teh',style: onboardingHeaderTextStyle,),
              MenuCategory(
                menuList: menuList,
                context: context,
                isGuest: isGuest,
                secondCategory: 'Teh',
              ),
              //Iced
              Text('Iced',style: onboardingHeaderTextStyle),
              MenuCategory(
                menuList: menuList,
                context: context,
                isGuest: isGuest,
                secondCategory: 'Iced',
              ),
              //Susu
              Text('Susu',style: onboardingHeaderTextStyle),
              MenuCategory(
                menuList: menuList,
                context: context,
                isGuest: isGuest,
                secondCategory: 'Susu',
              ),
            ],
          ),
        );
      },
    );
  }
}
