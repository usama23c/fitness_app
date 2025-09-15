import 'exercise_model.dart';

class WorkoutModel {
  final String id;
  final String title;
  final String subtitle;
  final String duration;
  final String calories;
  final String imagePath;
  final List<Exercise> exercises;
  final bool isForFemale;
  final bool isPremium;
  final String? difficulty;
  final bool isNew;

  const WorkoutModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.calories,
    required this.imagePath,
    required this.exercises,
    this.isForFemale = false,
    this.isPremium = false,
    this.difficulty,
    this.isNew = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'duration': duration,
      'calories': calories,
      'imagePath': imagePath,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'isForFemale': isForFemale,
      'isPremium': isPremium,
      'difficulty': difficulty,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map, String id) {
    return WorkoutModel(
      id: id,
      title: map['title'] as String? ?? 'Unknown Workout',
      subtitle: map['subtitle'] as String? ?? '',
      duration: map['duration'] as String? ?? '0 min',
      calories: map['calories'] as String? ?? '0 kcal',
      imagePath: map['imagePath'] as String? ?? '',
      exercises: (map['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isForFemale: map['isForFemale'] as bool? ?? false,
      isPremium: map['isPremium'] as bool? ?? false,
      difficulty: map['difficulty'] as String?,
    );
  }
}
