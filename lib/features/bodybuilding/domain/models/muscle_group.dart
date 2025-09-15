import 'package:flutter/material.dart';
import 'exercise_model.dart';

class MuscleGroup {
  final String name;
  final IconData icon;
  final String image;
  final Color primaryColor;
  final List<Exercise> exercises;
  final bool isForFemale;

  const MuscleGroup({
    required this.name,
    required this.icon,
    required this.image,
    required this.primaryColor,
    required this.exercises,
    this.isForFemale = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'isForFemale': isForFemale,
    };
  }

  factory MuscleGroup.fromMap(Map<String, dynamic> map) {
    return MuscleGroup(
      name: map['name'] as String? ?? '',
      icon: _getIconForGroup(map['name'] as String? ?? ''),
      image: map['image'] as String? ?? '',
      primaryColor: _getColorForGroup(map['name'] as String? ?? ''),
      exercises: (map['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isForFemale: map['isForFemale'] as bool? ?? false,
    );
  }

  static IconData _getIconForGroup(String name) {
    switch (name.toLowerCase()) {
      case 'chest':
        return Icons.fitness_center;
      case 'back':
        return Icons.back_hand;
      case 'legs':
        return Icons.directions_walk;
      case 'arms':
        return Icons.pan_tool_alt;
      case 'shoulders':
        return Icons.accessibility_new;
      case 'glutes':
        return Icons.directions_run;
      case 'core':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  static Color _getColorForGroup(String name) {
    switch (name.toLowerCase()) {
      case 'chest':
        return Colors.blue.shade700;
      case 'back':
        return Colors.deepOrange.shade700;
      case 'legs':
        return Colors.purple.shade700;
      case 'arms':
        return Colors.red.shade700;
      case 'shoulders':
        return Colors.teal.shade700;
      case 'glutes':
        return Colors.pink.shade700;
      case 'core':
        return Colors.green.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }
}
