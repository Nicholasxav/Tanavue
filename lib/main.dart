import 'package:flutter/material.dart';
import 'utils/app_colors.dart';
import 'utils/app_strings.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/panen_screen.dart';
// import 'screens/monitoring_screen.dart'; // <-- Import MonitoringScreen
// import 'screens/panen_screen.dart'; // <-- Import PanenScreen
import 'screens/plant_detail_screen.dart';

// Main function to run the Flutter application
void main() {
  runApp(const TanavueApp());
}

class TanavueApp extends StatelessWidget {
  const TanavueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanavue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // --- Your existing theme data remains unchanged ---
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          brightness: Brightness.light,
        ),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
          displayMedium: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
          titleLarge: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary),
          titleMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary),
          bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.textPrimary),
          bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textSecondary),
          labelLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.buttonTextWhite),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.buttonGreen,
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonGreen,
              foregroundColor: AppColors.buttonTextWhite,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              textStyle:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.dividerColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: AppColors.dividerColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 2.0)),
          hintStyle: const TextStyle(color: AppColors.textSecondary),
          labelStyle: const TextStyle(color: AppColors.textPrimary),
        ),
        cardTheme: CardTheme(
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: AppColors.cardBackground,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter'),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.cardBackground,
          selectedItemColor: AppColors.iconColorActive,
          unselectedItemColor: AppColors.iconColor,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          type: BottomNavigationBarType.fixed,
          elevation: 8.0,
        ),
        // --- End of your existing theme data ---
      ),

      // Set the initial route. Usually '/', but '/home' can be used for testing nav bar.
      initialRoute: '/',

      // Define all the possible named routes
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),

        // --- Updated Bottom Navigation Routes ---
        AppStrings.homeRoute: (context) => const HomeScreen(),
        AppStrings.monitoringRoute: (context) => const MonitoringScreen(),
        AppStrings.panenRoute: (context) => const PanenScreen(),

        // --- Keep your Plant Detail Route ---
        // It's generally better to let PlantDetailScreen handle
        // argument extraction via ModalRoute.of(context)
        // This definition allows navigating to it, but expects arguments
        // to be passed via Navigator.pushNamed(context, '/plant_detail', arguments: {...})
        // '/plant_detail': (context) => const PlantDetailScreen(
        //       // These values will be used if no arguments are passed,
        //       // but it's best to ensure arguments *are* passed.
        //       plantName: 'Detail',
        //       plantImageUrl: 'assets/images/plant_placeholder.png',
        //     ),
      },
    );
  }
}

// --- IMPORTANT ---
// You will need to create a 'panen_screen.dart' file similar to HomeScreen
// and MonitoringScreen, which includes a Scaffold and the
// AppBottomNavBar(currentIndex: 2).
//
// Example 'panen_screen.dart':
/*
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../widgets/app_bottom_nav_bar.dart';

class PanenScreen extends StatelessWidget {
  const PanenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.panen, style: TextStyle(color: AppColors.darkText)),
        backgroundColor: AppColors.background,
        elevation: 1,
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text('Panen Screen Content Goes Here'),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }
}
*/
