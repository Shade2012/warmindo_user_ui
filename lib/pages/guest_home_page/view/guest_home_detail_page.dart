import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warmindo_user_ui/utils/themes/textstyle_themes.dart';
import 'package:warmindo_user_ui/widget/appBar.dart';
import 'package:warmindo_user_ui/widget/reusable_card.dart';

import '../../menu_page/model/menu_model.dart';


class GuestFilteredMenuPage extends StatelessWidget {

  final List<Menu> filteredMenu;
  int price;

  GuestFilteredMenuPage({Key? key, required this.filteredMenu,required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Scaffold(
      appBar: AppbarCustom(title:'Menu Seharga ${currencyFormat.format(price)}', style: headerRegularStyle,),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 240
            ),
            itemCount: filteredMenu.length,
            itemBuilder: (context, index) {
              final menu = filteredMenu[index];
              return ReusableCard(context: context, product: menu, width: MediaQuery.of(context).size.width * 0.8, isGuest: true,);
            },
          ),
        ),
      ),
    );
  }
}