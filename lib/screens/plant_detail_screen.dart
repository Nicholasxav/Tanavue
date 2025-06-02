import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Corrected import
import '../utils/app_strings.dart'; // Corrected import
import '../widgets/app_bottom_widget.dart'; // Import the new Nav Bar

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  int _selectedIndex = 1; // 1 for Monitoring (as per the image)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // TODO: Implement navigation logic here
      // if (index == 0) Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildPrakiraanCuacaSection(context),
              const SizedBox(height: 40),
              _buildMonitorTanamanSection(context),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      // Use the reusable AppBottomNavBar with the correct index
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }

  // Prakiraan Cuaca Section Widget
  Widget _buildPrakiraanCuacaSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.prakiraanCuaca,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.darkText)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWeatherCard(context, AppStrings.now, Icons.thunderstorm,
                "23°", AppColors.weatherNowBg, Colors.white),
            _buildWeatherCard(context, "09.00", Icons.wb_cloudy, "25°",
                AppColors.weatherFutureBg, AppColors.darkText,
                isPartlyCloudy: true),
            _buildWeatherCard(context, "10.00", Icons.wb_cloudy, "26°",
                AppColors.weatherFutureBg, AppColors.darkText,
                isPartlyCloudy: true),
          ],
        ),
        const SizedBox(height: 12),
        const Text(AppStrings.cuacaDesc,
            style: TextStyle(fontSize: 12, color: AppColors.greyText)),
        const SizedBox(height: 4),
        const Row(children: [
          Text("Data Provided by ",
              style: TextStyle(fontSize: 10, color: AppColors.greyText)),
          Text("AccuWeather",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold)),
        ]),
      ],
    );
  }

  Widget _buildWeatherCard(BuildContext context, String time, IconData icon,
      String temp, Color bgColor, Color fgColor,
      {bool isPartlyCloudy = false}) {
    final cardWidth = (MediaQuery.of(context).size.width - 40 - 24) / 3;
    return Card(
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time, style: TextStyle(color: fgColor, fontSize: 13)),
            const SizedBox(height: 8),
            Stack(alignment: Alignment.center, children: [
              Icon(icon,
                  color: isPartlyCloudy ? Colors.white : fgColor, size: 40),
              if (isPartlyCloudy)
                Positioned(
                    top: 5,
                    right: 0,
                    child: Icon(Icons.wb_sunny,
                        color: AppColors.weatherSun, size: 20)),
            ]),
            const SizedBox(height: 8),
            Text(temp,
                style: TextStyle(
                    color: fgColor, fontSize: 22, fontWeight: FontWeight.bold)),
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
}
