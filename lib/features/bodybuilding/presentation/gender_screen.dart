import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/features/bodybuilding/presentation/bodybuilding_screen.dart';

class GenderScreen extends StatelessWidget {
  final String userId;

  const GenderScreen({super.key, required this.userId});

  void _navigateToScreen(BuildContext context, bool isMale) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BodybuildingScreen(
          isFemale: !isMale,
          userId: userId,
        ),
      ),
    );
  }

  Widget _buildGenderTile({
    required String label,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 6,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Back button ka kaam
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "SELECT YOUR GENDER",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Customized workouts for your fitness goals",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildGenderTile(
                      label: "MALE",
                      imagePath: AppImages.fullBodyWorkout,
                      onTap: () => _navigateToScreen(context, true),
                    ),
                    const SizedBox(width: 16),
                    _buildGenderTile(
                      label: "FEMALE",
                      imagePath: AppImages.femaleFullBody,
                      onTap: () => _navigateToScreen(context, false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
