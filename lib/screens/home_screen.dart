import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
// Make sure these imports point to your actual files
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../widgets/app_bottom_widget.dart';
import '../screens/profile_page.dart'; // Ensure this is ProfileSettingsScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  // Data for Prediksi Panen
  static final List<Map<String, String>> _prediksiPanenData = [
    {
      'name': 'Kangkung',
      'time': '10 Hari',
      'imageUrl': 'assets/images/kangkung.png'
    },
    {'name': 'Sawi', 'time': '25 Hari', 'imageUrl': 'assets/images/sawi.png'},
    {
      'name': 'Tomat',
      'time': '1 Bulan 20 Hari',
      'imageUrl': 'assets/images/tomat.png'
    },
    {
      'name': 'Sawi',
      'time': '1 Bulan 20 Hari',
      'imageUrl': 'assets/images/sawi.png'
    },
  ];

  // Data for the scrolling cards - NOW WITH IMAGES
  static final List<Map<String, String>> _infoCardsData = [
    {
      'title': AppStrings.apaCobaTitle,
      'body': AppStrings.apaCobaBody,
      'imageUrl': 'assets/images/info_card_1.png', // <-- Add image paths
    },
    {
      'title': "Tips Perawatan",
      'body':
          "Pastikan tanaman Anda mendapatkan cahaya matahari yang cukup setiap hari.",
      'imageUrl': 'assets/images/info_card_2.png', // <-- Add image paths
    },
    {
      'title': "Update Fitur!",
      'body': "Sekarang Anda bisa memantau pH air langsung dari aplikasi.",
      'imageUrl': 'assets/images/info_card_3.png', // <-- Add image paths
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _currentPage =
            (_pageController.page!.round() + 1) % _infoCardsData.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            AppStrings.welcome,
            style: TextStyle(
                color: AppColors.darkText,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileSettingsScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: AppColors.primaryGreen,
                radius: 20,
                child:
                    Icon(Icons.person_outline, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- REMOVED SEPARATE IMAGE CONTAINER ---

            // --- SCROLLABLE CARDS (PageView) - Height adjusted ---
            SizedBox(
              height: 250, // <-- Increased height to accommodate images
              child: PageView.builder(
                controller: _pageController,
                itemCount: _infoCardsData.length,
                itemBuilder: (context, index) {
                  final cardData = _infoCardsData[index];
                  // Use AnimatedBuilder for subtle scale effect (optional)
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) *
                              250, // Use new height
                          width: Curves.easeOut.transform(value) *
                              MediaQuery.of(context).size.width,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 10.0), // Spacing
                      child: _buildInfoCard(
                        // <-- Pass all data
                        cardData['title']!,
                        cardData['body']!,
                        cardData['imageUrl']!,
                      ),
                    ),
                  );
                },
              ),
            ),
            // --- END NEW SCROLLABLE CARDS ---

            const SizedBox(height: 20), // Adjusted spacing
            // Add Padding back for sections below
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildMonitorTanamanSection(context),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildPrediksiPanenSection(context),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  // --- UPDATED _buildInfoCard to handle Overflow ---
  Widget _buildInfoCard(String title, String body, String imageUrl) {
    return Card(
      color: AppColors.placeholderBg,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      clipBehavior: Clip.antiAlias, // Important for image corners
      child: Column(
        // Use Column to stack Image and Text
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image part (keeps its height)
          Image.asset(
            imageUrl,
            height: 120, // Height for the image part
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 120,
              color: Colors.grey[400],
              child:
                  const Center(child: Icon(Icons.image, color: Colors.white)),
            ),
          ),

          // Text part - WRAPPED WITH EXPANDED & SingleChildScrollView
          Expanded(
            // <-- 1. Added Expanded
            child: SingleChildScrollView(
              // <-- 2. Added SingleChildScrollView
              padding: const EdgeInsets.all(15.0), // <-- 3. Moved Padding here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkText),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    body,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.greyText),
                    // No maxLines needed now, as it can scroll
                  ),
                ],
              ),
            ),
          ),
          // --- END OF WRAPPED TEXT PART ---
        ],
      ),
    );
  }
  // --- RESTORED HELPER WIDGETS ---

  Widget _buildMonitorTanamanSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.monitorTanaman,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.darkText)),
            const Text(AppStrings.blynkData,
                style: TextStyle(fontSize: 10, color: AppColors.greyText)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMonitorCard(Icons.water_drop_outlined, AppStrings.kelembapan,
                "xx%", AppColors.cardGreen, context),
            _buildMonitorCard(Icons.thermostat_outlined, AppStrings.suhu,
                "xx°C", AppColors.cardYellow, context),
            _buildMonitorCard(Icons.science_outlined, AppStrings.phAir, "xx",
                AppColors.cardBlue, context),
          ],
        ),
      ],
    );
  }

  Widget _buildMonitorCard(IconData icon, String title, String value,
      Color color, BuildContext context) {
    final cardWidth = (MediaQuery.of(context).size.width - 40 - 24) / 3;
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  Widget _buildPrediksiPanenSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.prediksiPanen,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.darkText)),
        const SizedBox(height: 16),
        Column(
            children: _prediksiPanenData
                .map((plant) => _buildPrediksiCard(
                    plant['imageUrl']!, plant['name']!, plant['time']!))
                .toList()),
      ],
    );
  }

  Widget _buildPrediksiCard(
      String imageUrl, String plantName, String harvestTime) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  width: 45,
                  height: 45,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              child: Text(plantName,
                  style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.darkText,
                      fontWeight: FontWeight.w500))),
          const SizedBox(
              height: 30,
              child: VerticalDivider(color: AppColors.greyText, thickness: 1)),
          const SizedBox(width: 16),
          Text(harvestTime,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkText,
                  fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
        ]),
      ),
    );
  }
}

// --- You still need your AppBottomNavBar widget defined elsewhere ---
// Example:
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(int index, BuildContext context) {
    if (index == currentIndex) return;
    String routeName;
    switch (index) {
      case 0:
        routeName = '/home';
        break;
      case 1:
        routeName = '/monitoring';
        break;
      case 2:
        routeName = '/panen';
        break;
      default:
        return;
    }
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(currentIndex == 1 ? Icons.eco : Icons.eco_outlined),
            label: "Monitoring"),
        BottomNavigationBarItem(
            icon: Icon(currentIndex == 2
                ? Icons.agriculture
                : Icons.agriculture_outlined),
            label: "Panen"),
      ],
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.greyText,
      onTap: (index) => _onItemTapped(index, context),
    );
  }
}
