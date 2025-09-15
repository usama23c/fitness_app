import 'package:flutter/material.dart';
import 'package:fitness_app/features/bodybuilding/presentation/bodybuilding_screen.dart';

class FemaleBodybuildingScreen extends StatelessWidget {
  final String userId; // Add userId parameter

  const FemaleBodybuildingScreen({
    super.key,
    required this.userId, // Make userId required
  });

  @override
  Widget build(BuildContext context) {
    return BodybuildingScreen(
      isFemale: true,
      userId: userId, // Pass userId to BodybuildingScreen
    );
  }
}
