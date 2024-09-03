import 'package:flutter/material.dart';
import '../../common/model/menu_list_API_model.dart';
import '../../utils/themes/textstyle_themes.dart';
import 'menucard_widget.dart';
class AllMenu extends StatelessWidget {
  final List<MenuList> menuList;
  final bool isGuest;
   const AllMenu({super.key, required this.menuList, required this.isGuest});

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
                //Mie
                Text('Mie',style: onboardingHeaderTextStyle),
                MenuCategory(
                  menuList: menuList,
                  context: context,
                  isGuest: isGuest,
                  secondCategory: 'Mie',
                ),
                //Ayam
                Text('Ayam',style: onboardingHeaderTextStyle),
                MenuCategory(
                  menuList: menuList,
                  context: context,
                  isGuest: isGuest,
                  secondCategory: 'Ayam',
                ),
                //Nasi Goreng
                Text('Nasi Goreng',style: onboardingHeaderTextStyle),
                MenuCategory(
                  menuList: menuList,
                  context: context,
                  isGuest: isGuest,
                  secondCategory: 'Nasi Goreng',
                ),
                //Ricebowl
                Text('Ricebowl',style: onboardingHeaderTextStyle),
                MenuCategory(
                  menuList: menuList,
                  context: context,
                  isGuest: isGuest,
                  secondCategory: 'Ricebowl',
                ),
                //Lain-lain
                Text('Lain-lain',style: onboardingHeaderTextStyle),
                MenuCategory(
                  menuList: menuList,
                  context: context,
                  isGuest: isGuest,
                  secondCategory: 'Lain-lain',
                ),
              ],
            ),
        );
      },
    );
  }
}
