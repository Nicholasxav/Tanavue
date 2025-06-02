import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Corrected import
import '../utils/app_strings.dart'; // Corrected import

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_filled),
          label: AppStrings.navHome,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined), // Or explore_outlined
          activeIcon: Icon(Icons.search), // Or explore
          label: AppStrings.navDiscover,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner_outlined),
          activeIcon: Icon(Icons.qr_code_scanner),
          label: AppStrings.navScan,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_florist_outlined), // Or yard_outlined
          activeIcon: Icon(Icons.local_florist), // Or yard
          label: AppStrings.navGarden,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: AppStrings.navProfile,
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      // Theme settings are applied globally in main.dart's ThemeData
      // but you can override them here if needed.
      // type: BottomNavigationBarType.fixed, // Ensures labels are always visible
      // selectedItemColor: AppColors.iconColorActive,
      // unselectedItemColor: AppColors.iconColor,
      // backgroundColor: AppColors.cardBackground,
      // elevation: 8.0,
    );
  }
}
