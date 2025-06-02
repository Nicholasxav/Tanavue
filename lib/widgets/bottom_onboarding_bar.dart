import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BottomOnboardingBar extends StatelessWidget {
  final PageController pageController;
  final int numPages;
  final bool showPreviousButton;
  final String buttonText;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const BottomOnboardingBar({
    super.key,
    required this.pageController,
    required this.numPages,
    required this.showPreviousButton,
    required this.buttonText,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol Sebelumnya (Hanya tampil jika bukan halaman pertama)
          Visibility(
            visible: showPreviousButton,
            maintainSize: true, // Agar layout tidak bergeser
            maintainAnimation: true,
            maintainState: true,
            child: TextButton(
              onPressed: onPreviousPressed, // <-- Gunakan callback
              child: Text(
                "Sebelumnya",
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Indikator Halaman
          SmoothPageIndicator(
            controller: pageController, // <-- Gunakan controller yang diterima
            count: numPages, // <-- Gunakan jumlah halaman
            effect: ExpandingDotsEffect(
              dotColor: Colors.lightGreen.shade200,
              activeDotColor: Colors.green.shade800,
              dotHeight: 8,
              dotWidth: 16,
              spacing: 6,
            ),
          ),

          // Tombol Berikutnya / Mari Mulai
          TextButton(
            onPressed: onNextPressed, // <-- Gunakan callback
            child: Text(
              buttonText, // <-- Gunakan teks yang diterima
              style: TextStyle(
                color: Colors.green.shade900,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
