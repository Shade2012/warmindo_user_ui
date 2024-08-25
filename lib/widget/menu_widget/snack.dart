import 'package:flutter/material.dart';
import '../../common/model/menu_list_API_model.dart';
import '../../utils/themes/textstyle_themes.dart';
import 'menucard_widget.dart';
class SnackMenu extends StatelessWidget {
  final List<MenuList> menuList;
  final bool isGuest;
  const SnackMenu({super.key, required this.menuList, required this.isGuest});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Gorengan
              Text('Gorengan',style: onboardingHeaderTextStyle),
              MenuCategory(
                menuList: menuList,
                context: context,
                isGuest: isGuest,
                secondCategory: 'Gorengan',
              ),
            ],
          ),
        );
      },
    );
  }
}
