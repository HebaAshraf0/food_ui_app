import 'package:flutter/material.dart';
import 'package:food_ui_app/design_system/colors.dart';

import '../widgets/home_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      key: _key,
      backgroundColor: ColorsModel.background,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => _key.currentState!.openDrawer(),
          child: const Icon(
            Icons.menu_open,
            color: ColorsModel.black,
          ),
        ),
        actions: const [
          Icon(
            Icons.shopping_cart,
            color: ColorsModel.gray,
          )
        ],
      ),
      drawer: HomeDrawer(),
    );
  }
}
