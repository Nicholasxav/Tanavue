import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Pastikan import ini benar
import '../utils/app_strings.dart'; // Pastikan import ini benar
import '../widgets/app_bottom_widget.dart'; // Import the new Nav Bar
// Untuk FadePageRoute

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Set to 0 for Home to be initially selected

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // TODO: Implement navigation logic here
    });
  }

  // Data for Prediksi Panen
  final List<Map<String, String>> _prediksiPanenData = [
    {
      'name': 'Kangkung',
      'time': '10 Hari',
      'imageUrl': 'assets/images/kangkung.png' // Replace with your asset path
    },
    {
      'name': 'Sawi',
      'time': '25 Hari',
      'imageUrl': 'assets/images/sawi.png' // Replace with your asset path
    },
    {
      'name': 'Tomat',
      'time': '1 Bulan 20 Hari',
      'imageUrl': 'assets/images/tomat.png' // Replace with your asset path
    },
    {
      'name': 'Sawi', // Another Sawi entry as per image
      'time': '1 Bulan 20 Hari',
      'imageUrl': 'assets/images/sawi.png' // Replace with your asset path
    },
  ];

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
                backgroundColor: AppColors.primaryGreen, radius: 20),
          ),
        ],
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildPlaceholderCard(),
            const SizedBox(height: 30),
            _buildMonitorTanamanSection(context),
            const SizedBox(height: 30),
            _buildPrediksiPanenSection(context),
            const SizedBox(height: 80), // Keep space for nav bar aesthetics
          ],
        ),
      ),
      // Use the reusable AppBottomNavBar with the correct index
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildPlaceholderCard() {
    return Card(
      color: AppColors.placeholderBg, // Assuming AppColors.placeholderBg exists
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25.0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.apaCobaTitle,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText)),
            SizedBox(height: 8),
            Text(AppStrings.apaCobaBody,
                style: TextStyle(fontSize: 14, color: AppColors.greyText)),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

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
