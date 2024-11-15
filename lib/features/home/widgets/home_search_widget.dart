import 'package:flutter/material.dart';
import 'package:food_ui_app/design_system/colors.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: ColorsModel.lightGray,
      ),
      child: TextFormField(
        initialValue: 'Search',
      ),
    );
  }
}
