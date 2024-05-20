import 'package:flutter/material.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/appBar.dart';
import 'package:warmindo_user_ui/widget/reusable_card.dart';

import '../../menu_page/model/menu_model.dart';


class FilteredMenuPage extends StatelessWidget {

  final List<Menu> filteredMenu;
  int price;

  FilteredMenuPage({Key? key, required this.filteredMenu,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title:'Promo ${price}', style: headerRegularStyle,),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.7),
          ),
          itemCount: filteredMenu.length,
          itemBuilder: (context, index) {
            final menu = filteredMenu[index];
            return ReusableCard(context: context, product: menu, width: MediaQuery.of(context).size.width * 0.8,);
          },
        ),
      ),
    );
  }
}
