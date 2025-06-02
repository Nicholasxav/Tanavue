import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Corrected import
import '../utils/app_strings.dart'; // Corrected import

class PlantCard extends StatelessWidget {
  final String plantName;
  final String plantType;
  final String imageUrl; // Expecting an asset path
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plantName,
    required this.plantType,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0, // As per item_plant_card.xml elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: AppColors.cardBackground,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(8.0), // For rounded corners on image
                child: Image.asset(
                  imageUrl,
                  width: 80, // Adjusted size to better fit the card layout
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image fails to load
                    return Container(
                      width: 80,
                      height: 80,
                      color: AppColors.lightGreenBackground,
                      child: const Icon(Icons.broken_image_outlined,
                          color: AppColors.primary, size: 40),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      plantName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plantType,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
