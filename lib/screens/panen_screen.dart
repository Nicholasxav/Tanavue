import 'package:flutter/material.dart';
// Make sure these imports point to your actual files
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../widgets/app_bottom_widget.dart'; // Import the Nav Bar

class PanenScreen extends StatelessWidget {
  const PanenScreen({super.key});

  // Data for Prediksi Panen (can be shared or fetched)
  static final List<Map<String, String>> _prediksiPanenData = [
    {'name': 'Kangkung', 'time': '10 Hari'},
    {'name': 'Sawi', 'time': '25 Hari'},
    {'name': 'Tomat', 'time': '1 Bulan 20 Hari'},
  ];

  // Function to show the "Add Plant" dialog
  void _showAddPlantDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0), // Rounded corners for dialog
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            // Allow scroll on small screens
            child: Column(
              mainAxisSize: MainAxisSize.min, // Make column take minimum space
              children: <Widget>[
                const Text(
                  "Tambahkan Tanaman",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
                const SizedBox(height: 25),
                // Input Field: Nama Tanaman
                TextField(
                  decoration: InputDecoration(
                    labelText: "Nama Tanaman",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                  ),
                ),
                const SizedBox(height: 15),
                // Input Field: Durasi Panen
                TextField(
                  decoration: InputDecoration(
                    labelText: "Durasi Panen",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                  ),
                ),
                const SizedBox(height: 20),
                // Upload Area (Simple Placeholder)
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1), // Simple border
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload_outlined,
                            color: Colors.grey, size: 30),
                        SizedBox(height: 5),
                        Text("Upload Foto",
                            style: TextStyle(color: Colors.grey)),
                        Text("Klik Disini",
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  // TODO: Add InkWell or GestureDetector for tap handling
                ),
                const SizedBox(height: 25),
                // Button
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Add Plant Logic
                    Navigator.of(context).pop(); // Close dialog on press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primaryGreen, // Use your green color
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Tambahkan Tanaman",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Daftar Tanaman Hidroponik",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
              ),
              const SizedBox(height: 20),
              // Featured Card
              _buildFeaturedCard(context),
              const SizedBox(height: 30),
              // Prediksi Panen Title
              Text(
                AppStrings.prediksiPanen,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkText,
                    ),
              ),
              const SizedBox(height: 12),
              // Prediksi Panen List
              Column(
                children: _prediksiPanenData.map((plant) {
                  return _buildPrediksiSimpleCard(
                      plant['name']!, plant['time']!);
                }).toList(),
              ),
              const SizedBox(height: 30),
              // Add Plant Button
              ElevatedButton(
                onPressed: () =>
                    _showAddPlantDialog(context), // Show dialog on press
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryGreen, // Use your green color
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Tambahkan Tanaman",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20), // Padding at the bottom
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const AppBottomNavBar(currentIndex: 2), // Index 2 for Panen
    );
  }

  // --- Helper Widgets for PanenScreen ---

  // Featured Kangkung Card
  Widget _buildFeaturedCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Ensures image corners are rounded
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 3.0,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            'assets/images/kangkung_large.png', // <-- Make sure you have this image
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.broken_image, size: 50)),
            ),
          ),
          // Gradient overlay for better text readability
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Text Overlay
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "Kangkung",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 2.0, color: Colors.black54)],
                  ),
                ),
                const Text(
                  "10 Hari",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 2.0, color: Colors.black54)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Simple Prediction Card (without image)
  Widget _buildPrediksiSimpleCard(String plantName, String harvestTime) {
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                plantName,
                style: const TextStyle(fontSize: 16, color: AppColors.darkText),
              ),
            ),
            const SizedBox(
                height: 25, child: VerticalDivider(color: AppColors.greyText)),
            const SizedBox(width: 16),
            Text(
              harvestTime,
              style: const TextStyle(fontSize: 16, color: AppColors.darkText),
            ),
          ],
        ),
      ),
    );
  }
}
