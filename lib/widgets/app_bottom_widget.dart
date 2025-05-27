import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Corrected import
import '../utils/app_strings.dart'; // Corrected import

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex; // The index of the *current* page

  const AppBottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(int index, BuildContext context) {
    // Prevent navigating to the same page
    if (index == currentIndex) {
      return;
    }

    String routeName;
    switch (index) {
      case 0:
        routeName = AppStrings.homeRoute;
        break;
      case 1:
        routeName = AppStrings.monitoringRoute;
        break;
      case 2:
        routeName = AppStrings.panenRoute;
        break;
      default:
        return; // Exit if index is unknown
    }
    // Use pushReplacementNamed for navigation
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    // This is the code block you provided, adapted to use
    // the passed `currentIndex` and our `_onItemTapped` logic.
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(currentIndex == 1 ? Icons.eco : Icons.eco_outlined),
          label: AppStrings.monitoring,
        ),
        BottomNavigationBarItem(
          icon: Icon(currentIndex == 2
              ? Icons.agriculture
              : Icons.agriculture_outlined),
          label: AppStrings.panen,
        ),
      ],
      currentIndex: currentIndex, // Use the passed index
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.iconGrey,
      onTap: (index) => _onItemTapped(index, context), // Call our nav logic
      backgroundColor: Colors.white,
      elevation: 10.0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
