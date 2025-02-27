import 'package:flutter/material.dart';
import 'package:health_routine/presentation/theme/app_color.dart';
import 'package:health_routine/presentation/theme/app_text_style.dart';

class WorkoutTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  const WorkoutTabBar({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        tabs.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(tabs[index]),
            selected: selectedTab == index,
            onSelected: (selected) {
              if (selected) onTabSelected(index);
            },
            showCheckmark: false,
            selectedColor: AppColors.secondColor,
            backgroundColor: Colors.transparent,
            shape: selectedTab == index
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.transparent),
                  ),
            labelStyle: selectedTab == index
                ? AppTextStyle.smallTitle.copyWith(color: AppColors.white)
                : AppTextStyle.smallTitle,
          ),
        ),
      ),
    );
  }
}
