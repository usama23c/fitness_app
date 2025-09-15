import 'package:flutter/material.dart';

class AppColors {
  // Primary Color Palette (Google-inspired)
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF4285F4,
    <int, Color>{
      50: Color(0xFFE8F0FE),
      100: Color(0xFFD2E3FC),
      200: Color(0xFFAECBFA),
      300: Color(0xFF8AB4F8),
      400: Color(0xFF669DF6),
      500: Color(0xFF4285F4),
      600: Color(0xFF1A73E8),
      700: Color(0xFF1967D2),
      800: Color(0xFF185ABC),
      900: Color(0xFF174EA6),
    },
  );

  // Main Colors
  static const Color primary = Color(0xFF4285F4);
  static const Color secondary = Color(0xFF34A853);
  static const Color accent = Color(0xFFFBBC05);
  static const Color error = Color(0xFFEA4335);

  // Nutrition Colors (from your screens)
  static const Color protein = Color(0xFFFF6B6B);
  static const Color carbs = Color(0xFF51CF66);
  static const Color fats = Color(0xFFFCC419);
  static const Color fruitCategory = Color(0xFFFF9F1C);
  static const Color vegetableCategory = Color(0xFF2EC4B6);
  static const Color meatCategory = Color(0xFFE71D36);
  static const Color vegetarianCategory = Color(0xFF662E9B);

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF1F3F4);
  static const Color darkGrey = Color(0xFF5F6368);

  // Text Colors
  static const Color textPrimary = Color(0xFF202124);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color textDisabled = Color(0xFF9AA0A6);
  static const Color textOnPrimary = white;
  static const Color textOnDark = white;

  // Background Colors
  static const Color background = Color(0xFFF8F9FA); // Light background
  static const Color darkBackground = Color(0xFF121212); // Dark background
  static const Color surface = white;
  static const Color card = white;
  static const Color cardDark = Color(0xFF1E1E1E);

  // Semantic Colors
  static const Color success = Color(0xFF34A853);
  static const Color warning = Color(0xFFFBBC05);
  static const Color danger = Color(0xFFEA4335);
  static const Color info = Color(0xFF4285F4);

  // UI Elements
  static const Color divider = Color(0xFFDADCE0);
  static const Color border = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x42000000);
  static const Color overlay = Color(0x52000000);

  // Special Colors
  static const Color transparent = Color(0x00000000);
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4285F4), Color(0xFF34A853)],
  );

  // Screen-specific colors (from your implementations)
  static const Color workoutCardGradientStart = Color(0xFF4285F4);
  static const Color workoutCardGradientEnd = Color(0xFF34A853);
  static const Color mealDetailBackground = Color(0xFFF9F9F9);
  static const Color scanScreenOverlay = Color(0x52000000);
  static const Color successBackground = Color(0xFFE8F5E9);

  // Text variants
  static const Color textCaption = Color(0xFF70757A);
  static const Color textHint = Color(0xFF9AA0A6);

  // Missing colors that were declared but not initialized
  static const Color primaryDark = Color(0xFF1967D2);
  static const Color score = Color(0xFF4285F4);
  static const Color calorie = Color(0xFFFBBC05);
  static const Color workout = Color(0xFF34A853);
  static const Color hydration = Color(0xFF4285F4);
}
