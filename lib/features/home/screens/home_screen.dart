import 'package:flutter/material.dart';
import 'package:food_ui_app/design_system/colors.dart';

import '../home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsModel.background,
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            highlightColor: ColorsModel.lightOrange,
            hoverColor: ColorsModel.lightOrange,
            icon: Icon(
              Icons.menu,
            ),
            color: ColorsModel.gray,
            onPressed: () => _onPressed(context),
          );
        }),
        actions: const [
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.shopping_cart,
              color: ColorsModel.lightGray,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Delicious                              food for you',
              maxLines: 2,
              style: TextStyle(
                  color: ColorsModel.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: ColorsModel.lightGray.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Row(
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'search',
                    style: TextStyle(
                      color: ColorsModel.gray,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressed(BuildContext context) {
    if (isOpened) {
      context.findAncestorStateOfType<HomeDrawerState>()?.close();
      setState(() {
        isOpened = false;
      });
      return;
    }
    context.findAncestorStateOfType<HomeDrawerState>()?.open();
    setState(() {
      isOpened = true;
    });
  }
}
