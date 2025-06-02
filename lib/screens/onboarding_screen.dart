import 'package:flutter/material.dart';
import '../widgets/bottom_onboarding_bar.dart'; // Tetap gunakan widget bar bawah
import 'login_screen.dart';
import '../utils/custom_page_route.dart'; // Jika ingin pakai fade transition

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  // Daftar path gambar untuk setiap halaman onboarding
  final List<String> _imagePaths = [
    'assets/images/onboard_1.png', // Ganti dengan path gambar Anda
    'assets/images/onboard_2.png', // Ganti dengan path gambar Anda
  ];

  late int _numPages; // Jumlah halaman akan diambil dari panjang daftar gambar
  int _currentPage = 0;
  String _buttonText = "Berikutnya";
  bool _showPreviousButton = false;

  @override
  void initState() {
    super.initState();
    _numPages = _imagePaths.length; // Set jumlah halaman
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _buttonText = (page == _numPages - 1) ? "Mari Mulai" : "Berikutnya";
      _showPreviousButton = (page > 0);
    });
  }

  void _handleNextButton() {
    if (_currentPage == _numPages - 1) {
      print("Navigasi ke Halaman Login/Signup!");
      Navigator.of(context).pushReplacement(
        FadePageRoute(page: const LoginScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void _handlePreviousButton() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  // Widget untuk menampilkan gambar di PageView
  Widget _buildImagePage(String imagePath) {
    return Container(
      color: const Color.fromARGB(
          255, 255, 255, 255), // Latar belakang hijau (bisa diganti putih)
      padding: const EdgeInsets.all(20.0), // Beri sedikit padding
      child: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain, // Agar gambar pas tanpa terpotong
          errorBuilder: (context, error, stackTrace) {
            // Tampilkan placeholder jika gambar gagal dimuat
            return Center(
              child: Icon(
                Icons.broken_image_outlined,
                size: 100,
                color: Colors.white.withOpacity(0.7),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              // Buat halaman dari daftar path gambar
              children:
                  _imagePaths.map((path) => _buildImagePage(path)).toList(),
            ),
          ),
          // Tetap gunakan widget bar bawah yang sudah dipisah
          BottomOnboardingBar(
            pageController: _pageController,
            numPages: _numPages,
            showPreviousButton: _showPreviousButton,
            buttonText: _buttonText,
            onPreviousPressed: _handlePreviousButton,
            onNextPressed: _handleNextButton,
          ),
        ],
      ),
    );
  }
}
