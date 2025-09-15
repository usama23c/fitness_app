class Exercise {
  final String name;
  final int sets;
  final dynamic reps; // Can be int or String like "AMRAP"
  final String rest;
  final String? instructions;
  final String? imagePath;

  const Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.rest,
    this.instructions,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'rest': rest,
      'instructions': instructions,
      'imagePath': imagePath,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] as String? ?? 'Unknown Exercise',
      sets: (map['sets'] as int?) ?? 3,
      reps: map['reps'] ?? 10,
      rest: map['rest'] as String? ?? '60s',
      instructions: map['instructions'] as String?,
      imagePath: map['imagePath'] as String?,
    );
  }
}
