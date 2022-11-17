import 'package:explore/shared/utils/export.dart';
import 'package:explore/shared/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    Key? key,
    required this.index,
    required this.tabTitle,
    required this.selectedIndex,
  }) : super(key: key);

  final String tabTitle;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: AppTextWidget(
        text: tabTitle,
        textColor: index == selectedIndex
            ? appColors.white
            : appColors.white.withOpacity(0.4),
        fontWeight: FontWeight.w600,
        fontSize: 18,
        // fontSize: 15,
      ),
    );
  }
}
