import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ui_app/design_system/colors.dart';

class MyHomeDrawer extends StatelessWidget {
  const MyHomeDrawer({super.key, required this.isAnimating});
  final bool isAnimating;
  static const List<Widget> items = [
    ListTile(
      leading: Icon(Icons.person),
      title: Text('Profile'),
    ),
    ListTile(
      leading: Icon(Icons.shopping_cart),
      title: Text('Orders'),
    ),
    ListTile(
      leading: Icon(Icons.local_offer_sharp),
      title: Text('Offers'),
    ),
    ListTile(
      leading: Icon(Icons.privacy_tip),
      title: Text('Privacy Policy'),
    ),
    ListTile(
      leading: Icon(Icons.security),
      title: Text('Security'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsModel.orange,
      child: SafeArea(
        child: Theme(
          data: ThemeData(
            brightness: Brightness.dark,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) => MyHomeDrawerListItem(
                  index: index,
                  item: items[index],
                  isAnimating: isAnimating,
                ),
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: ColorsModel.lightGray.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomeDrawerListItem extends StatefulWidget {
  const MyHomeDrawerListItem(
      {super.key,
      required this.index,
      required this.item,
      required this.isAnimating});
  final int index;
  final Widget item;
  final bool isAnimating;

  @override
  State<MyHomeDrawerListItem> createState() => _MyHomeDrawerListItemState();
}

class _MyHomeDrawerListItemState extends State<MyHomeDrawerListItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      sizeCurve: Curves.fastEaseInToSlowEaseOut,
      firstChild: widget.item,
      secondChild: SizedBox.shrink(),
      crossFadeState: widget.isAnimating
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
