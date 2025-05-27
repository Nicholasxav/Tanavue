import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'onboarding_screen.dart'; // <-- Import OnboardingScreen
import '../utils/custom_page_route.dart'; // <-- Import your custom route

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      // Use pushReplacement with your custom FadePageRoute
      Navigator.of(context).pushReplacement(
        FadePageRoute(
            page: const OnboardingScreen()), // <-- Use the custom route here
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Using the primary green color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Placeholder for the app logo
            // Replace 'assets/images/logo.png' with your actual logo path
            // Ensure you have added the logo to your pubspec.yaml assets
            Image.asset(
              'assets/images/logo_tanavue.png', // Example path
              width: 250,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if image fails to load
                return const Icon(Icons.eco,
                    size: 120, color: AppColors.textWhite);
              },
            )
          ],
        ),
      ),
    );
  }
}
