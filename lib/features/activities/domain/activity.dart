import 'package:flutter/material.dart';

enum ActivityType {
  running,
  cycling,
  swimming,
  workout,
  walking,
  yoga,
  hiking,
  dancing,
  basketball,
  football,
}

class Activity {
  final String id;
  final String name;
  final int duration; // in minutes
  final int calories; // kcal burned
  final ActivityType type;
  final DateTime date;
  final double? distance; // in kilometers
  final String? notes;
  final int? averageHeartRate; // bpm
  final double? elevationGain; // in meters
  final String? imageUrl;

  Activity({
    required this.name,
    required this.duration,
    required this.calories,
    required this.type,
    required this.date,
    this.distance,
    this.notes,
    this.averageHeartRate,
    this.elevationGain,
    this.imageUrl,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();

  // Helper method to get icon for each activity type
  IconData get icon {
    switch (type) {
      case ActivityType.running:
        return Icons.directions_run;
      case ActivityType.cycling:
        return Icons.directions_bike;
      case ActivityType.swimming:
        return Icons.pool;
      case ActivityType.workout:
        return Icons.fitness_center;
      case ActivityType.walking:
        return Icons.directions_walk;
      case ActivityType.yoga:
        return Icons.self_improvement;
      case ActivityType.hiking:
        return Icons.terrain;
      case ActivityType.dancing:
        return Icons.music_note;
      case ActivityType.basketball:
        return Icons.sports_basketball;
      case ActivityType.football:
        return Icons.sports_soccer;
    }
  }

  // Convert to map for Firebase or other databases
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'calories': calories,
      'type': type.toString().split('.').last,
      'date': date.toIso8601String(),
      'distance': distance,
      'notes': notes,
      'averageHeartRate': averageHeartRate,
      'elevationGain': elevationGain,
      'imageUrl': imageUrl,
    };
  }

  // Create from map (for database retrieval)
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      name: map['name'],
      duration: map['duration'],
      calories: map['calories'],
      type: ActivityType.values.firstWhere(
        (e) => e.toString() == 'ActivityType.${map['type']}',
      ),
      date: DateTime.parse(map['date']),
      distance: map['distance'],
      notes: map['notes'],
      averageHeartRate: map['averageHeartRate'],
      elevationGain: map['elevationGain'],
      imageUrl: map['imageUrl'],
    );
  }

  // Copy with method for easy updates
  Activity copyWith({
    String? name,
    int? duration,
    int? calories,
    ActivityType? type,
    DateTime? date,
    double? distance,
    String? notes,
    int? averageHeartRate,
    double? elevationGain,
    String? imageUrl,
  }) {
    return Activity(
      name: name ?? this.name,
      duration: duration ?? this.duration,
      calories: calories ?? this.calories,
      type: type ?? this.type,
      date: date ?? this.date,
      distance: distance ?? this.distance,
      notes: notes ?? this.notes,
      averageHeartRate: averageHeartRate ?? this.averageHeartRate,
      elevationGain: elevationGain ?? this.elevationGain,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
