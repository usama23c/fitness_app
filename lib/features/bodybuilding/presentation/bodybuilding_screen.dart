import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/features/bodybuilding/presentation/widgets/workout_card.dart';
import 'package:fitness_app/features/bodybuilding/domain/models/workout_model.dart';
import 'package:fitness_app/features/bodybuilding/domain/models/muscle_group.dart';
import 'package:fitness_app/features/bodybuilding/domain/models/exercise_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BodybuildingScreen extends StatefulWidget {
  final bool isFemale;
  final String userId;

  const BodybuildingScreen({
    super.key,
    required this.isFemale,
    required this.userId,
  });

  @override
  State<BodybuildingScreen> createState() => _BodybuildingScreenState();
}

class _BodybuildingScreenState extends State<BodybuildingScreen> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final List<MuscleGroup> muscleGroups;
  late final List<WorkoutModel> workouts;
  late final Color primaryColor;
  late final Color secondaryColor;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    primaryColor =
        widget.isFemale ? Colors.pink.shade400 : Colors.blue.shade400;
    secondaryColor =
        widget.isFemale ? Colors.purple.shade300 : Colors.cyan.shade300;

    muscleGroups = [
      if (widget.isFemale) ...[
        MuscleGroup(
          name: "Glutes",
          icon: Icons.directions_run,
          image: AppImages.femaleGlutesWorkout,
          primaryColor: primaryColor,
          exercises: _getFemaleGlutesExercises(),
          isForFemale: true,
        ),
        MuscleGroup(
          name: "Legs",
          icon: Icons.directions_walk,
          image: AppImages.femaleLegWorkout,
          primaryColor: primaryColor,
          exercises: _getFemaleLegsExercises(),
          isForFemale: true,
        ),
        MuscleGroup(
          name: "Core",
          icon: Icons.fitness_center,
          image: AppImages.femaleAbsWorkout,
          primaryColor: primaryColor,
          exercises: _getFemaleCoreExercises(),
          isForFemale: true,
        ),
        MuscleGroup(
          name: "Upper Body",
          icon: Icons.accessibility_new,
          image: AppImages.femaleUpperBody,
          primaryColor: primaryColor,
          exercises: _getFemaleUpperBodyExercises(),
          isForFemale: true,
        ),
        MuscleGroup(
          name: "Full Body",
          icon: Icons.self_improvement,
          image: AppImages.femaleFullBodyWorkout,
          primaryColor: primaryColor,
          exercises: _getFemaleFullBodyExercises(),
          isForFemale: true,
        ),
      ] else ...[
        MuscleGroup(
          name: "Chest",
          icon: Icons.fitness_center,
          image: AppImages.maleChestWorkout,
          primaryColor: primaryColor,
          exercises: _getMaleChestExercises(),
        ),
        MuscleGroup(
          name: "Back",
          icon: Icons.back_hand,
          image: AppImages.backWorkout,
          primaryColor: primaryColor,
          exercises: _getMaleBackExercises(),
        ),
        MuscleGroup(
          name: "Arms",
          icon: Icons.pan_tool_alt,
          image: AppImages.armsWorkout,
          primaryColor: primaryColor,
          exercises: _getMaleArmsExercises(),
        ),
        MuscleGroup(
          name: "Shoulders",
          icon: Icons.accessibility_new,
          image: AppImages.shouldersWorkout,
          primaryColor: primaryColor,
          exercises: _getMaleShouldersExercises(),
        ),
        MuscleGroup(
          name: "Legs",
          icon: Icons.directions_walk,
          image: AppImages.legsWorkout,
          primaryColor: primaryColor,
          exercises: _getMaleLegsExercises(),
        ),
      ],
    ];

    workouts = [
      if (widget.isFemale) ...[
        WorkoutModel(
          id: 'female_glutes_1',
          title: "Glute Activation",
          subtitle: "Wake up your glutes",
          duration: "30 min",
          calories: "200 kcal",
          imagePath: AppImages.femaleGlutesWorkout,
          exercises: _getFemaleGlutesExercises(),
          isForFemale: true,
        ),
        WorkoutModel(
          id: 'female_legs_1',
          title: "Leg Day Intensive",
          subtitle: "Squats & lunges",
          duration: "45 min",
          calories: "300 kcal",
          imagePath: AppImages.femaleLegWorkout,
          exercises: _getFemaleLegsExercises(),
          isForFemale: true,
        ),
        WorkoutModel(
          id: 'female_core_1',
          title: "Core Burner Pro",
          subtitle: "Abs & obliques",
          duration: "25 min",
          calories: "180 kcal",
          imagePath: AppImages.femaleAbsWorkout,
          exercises: _getFemaleCoreExercises(),
          isForFemale: true,
        ),
        WorkoutModel(
          id: 'female_upper_1',
          title: "Upper Body Tone",
          subtitle: "Arms & shoulders",
          duration: "35 min",
          calories: "220 kcal",
          imagePath: AppImages.femaleUpperBody,
          exercises: _getFemaleUpperBodyExercises(),
          isForFemale: true,
        ),
        WorkoutModel(
          id: 'female_full_1',
          title: "Full Body Sculpt",
          subtitle: "Complete workout",
          duration: "50 min",
          calories: "350 kcal",
          imagePath: AppImages.femaleFullBodyWorkout,
          exercises: _getFemaleFullBodyExercises(),
          isForFemale: true,
        ),
      ] else ...[
        WorkoutModel(
          id: 'male_chest_1',
          title: "Chest Builder Pro",
          subtitle: "Bench press & flys",
          duration: "40 min",
          calories: "250 kcal",
          imagePath: AppImages.maleChestWorkout,
          exercises: _getMaleChestExercises(),
        ),
        WorkoutModel(
          id: 'male_back_1',
          title: "Back Attack Plus",
          subtitle: "Pull-ups & rows",
          duration: "45 min",
          calories: "280 kcal",
          imagePath: AppImages.backWorkout,
          exercises: _getMaleBackExercises(),
        ),
        WorkoutModel(
          id: 'male_arms_1',
          title: "Arm Blaster X",
          subtitle: "Biceps & triceps",
          duration: "35 min",
          calories: "220 kcal",
          imagePath: AppImages.armsWorkout,
          exercises: _getMaleArmsExercises(),
        ),
        WorkoutModel(
          id: 'male_shoulders_1',
          title: "Shoulder Power",
          subtitle: "Deltoid focus",
          duration: "30 min",
          calories: "200 kcal",
          imagePath: AppImages.shouldersWorkout,
          exercises: _getMaleShouldersExercises(),
        ),
        WorkoutModel(
          id: 'male_legs_1',
          title: "Leg Day Beast",
          subtitle: "Squats & deadlifts",
          duration: "50 min",
          calories: "320 kcal",
          imagePath: AppImages.legsWorkout,
          exercises: _getMaleLegsExercises(),
        ),
      ],
    ];
  }

  // Female exercise lists
  List<Exercise> _getFemaleGlutesExercises() => [
        const Exercise(
          name: "Hip Thrusts",
          sets: 3,
          reps: 12,
          rest: "60s",
          instructions: "Keep your core engaged throughout the movement",
        ),
        const Exercise(
          name: "Bulgarian Split Squats",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Maintain balance and control",
        ),
        const Exercise(
          name: "Glute Bridges",
          sets: 3,
          reps: 15,
          rest: "45s",
          instructions: "Squeeze glutes at the top",
        ),
        const Exercise(
          name: "Donkey Kicks",
          sets: 3,
          reps: 12,
          rest: "30s",
          instructions: "Keep movements controlled",
        ),
        const Exercise(
          name: "Fire Hydrants",
          sets: 3,
          reps: 12,
          rest: "30s",
          instructions: "Focus on glute activation",
        ),
      ];

  List<Exercise> _getFemaleLegsExercises() => [
        const Exercise(
          name: "Squats",
          sets: 4,
          reps: 12,
          rest: "60s",
          instructions: "Keep knees behind toes",
        ),
        const Exercise(
          name: "Lunges",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Maintain upright posture",
        ),
        const Exercise(
          name: "Step-ups",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Use controlled movements",
        ),
        const Exercise(
          name: "Calf Raises",
          sets: 3,
          reps: 15,
          rest: "30s",
          instructions: "Full range of motion",
        ),
        const Exercise(
          name: "Inner Thigh Lifts",
          sets: 3,
          reps: 12,
          rest: "30s",
          instructions: "Slow and controlled",
        ),
      ];

  List<Exercise> _getFemaleCoreExercises() => [
        const Exercise(
          name: "Plank",
          sets: 3,
          reps: "30s",
          rest: "30s",
          instructions: "Keep body in straight line",
        ),
        const Exercise(
          name: "Russian Twists",
          sets: 3,
          reps: 15,
          rest: "30s",
          instructions: "Engage obliques",
        ),
        const Exercise(
          name: "Leg Raises",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Keep lower back pressed down",
        ),
        const Exercise(
          name: "Bicycle Crunches",
          sets: 3,
          reps: 20,
          rest: "30s",
          instructions: "Alternate sides smoothly",
        ),
        const Exercise(
          name: "Dead Bug",
          sets: 3,
          reps: 12,
          rest: "30s",
          instructions: "Maintain core tension",
        ),
      ];

  List<Exercise> _getFemaleUpperBodyExercises() => [
        const Exercise(
          name: "Push-ups",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Keep core engaged",
        ),
        const Exercise(
          name: "Dumbbell Rows",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Squeeze shoulder blades",
        ),
        const Exercise(
          name: "Shoulder Press",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Don't arch back",
        ),
        const Exercise(
          name: "Bicep Curls",
          sets: 3,
          reps: 12,
          rest: "30s",
          instructions: "Control the weight",
        ),
        const Exercise(
          name: "Tricep Dips",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Keep elbows tucked in",
        ),
      ];

  List<Exercise> _getFemaleFullBodyExercises() => [
        const Exercise(
          name: "Squat to Press",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Combine movements smoothly",
        ),
        const Exercise(
          name: "Burpees",
          sets: 3,
          reps: 10,
          rest: "60s",
          instructions: "Full range of motion",
        ),
        const Exercise(
          name: "Mountain Climbers",
          sets: 3,
          reps: 20,
          rest: "30s",
          instructions: "Keep core tight",
        ),
        const Exercise(
          name: "Jumping Jacks",
          sets: 3,
          reps: 30,
          rest: "30s",
          instructions: "Modify intensity as needed",
        ),
        const Exercise(
          name: "Plank Rows",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Maintain plank position",
        ),
      ];

  // Male exercise lists
  List<Exercise> _getMaleChestExercises() => [
        const Exercise(
          name: "Bench Press",
          sets: 4,
          reps: 8,
          rest: "90s",
          instructions: "Keep your back flat against the bench",
        ),
        const Exercise(
          name: "Incline Dumbbell Press",
          sets: 3,
          reps: 10,
          rest: "60s",
          instructions: "Control the descent",
        ),
        const Exercise(
          name: "Chest Flys",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Slight bend in elbows",
        ),
        const Exercise(
          name: "Push-ups",
          sets: 3,
          reps: 15,
          rest: "45s",
          instructions: "Full range of motion",
        ),
        const Exercise(
          name: "Dips",
          sets: 3,
          reps: "To Failure",
          rest: "60s",
          instructions: "Lean forward slightly",
        ),
      ];

  List<Exercise> _getMaleBackExercises() => [
        const Exercise(
          name: "Pull-ups",
          sets: 4,
          reps: 8,
          rest: "90s",
          instructions: "Full extension at bottom",
        ),
        const Exercise(
          name: "Bent Over Rows",
          sets: 3,
          reps: 10,
          rest: "60s",
          instructions: "Keep back straight",
        ),
        const Exercise(
          name: "Lat Pulldowns",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Squeeze at the bottom",
        ),
        const Exercise(
          name: "Deadlifts",
          sets: 3,
          reps: 8,
          rest: "90s",
          instructions: "Maintain neutral spine",
        ),
        const Exercise(
          name: "Face Pulls",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Squeeze shoulder blades",
        ),
      ];

  List<Exercise> _getMaleArmsExercises() => [
        const Exercise(
          name: "Barbell Curls",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Control the weight",
        ),
        const Exercise(
          name: "Tricep Pushdowns",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Keep elbows stationary",
        ),
        const Exercise(
          name: "Hammer Curls",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Neutral grip",
        ),
        const Exercise(
          name: "Skull Crushers",
          sets: 3,
          reps: 10,
          rest: "60s",
          instructions: "Control the movement",
        ),
        const Exercise(
          name: "Preacher Curls",
          sets: 3,
          reps: 10,
          rest: "45s",
          instructions: "Isolate biceps",
        ),
      ];

  List<Exercise> _getMaleShouldersExercises() => [
        const Exercise(
          name: "Overhead Press",
          sets: 4,
          reps: 8,
          rest: "60s",
          instructions: "Don't arch back",
        ),
        const Exercise(
          name: "Lateral Raises",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Control the weight",
        ),
        const Exercise(
          name: "Front Raises",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Avoid swinging",
        ),
        const Exercise(
          name: "Rear Delt Flys",
          sets: 3,
          reps: 12,
          rest: "45s",
          instructions: "Squeeze at the top",
        ),
        const Exercise(
          name: "Shrugs",
          sets: 3,
          reps: 15,
          rest: "45s",
          instructions: "Hold at the top",
        ),
      ];

  List<Exercise> _getMaleLegsExercises() => [
        const Exercise(
          name: "Squats",
          sets: 4,
          reps: 8,
          rest: "90s",
          instructions: "Maintain form",
        ),
        const Exercise(
          name: "Deadlifts",
          sets: 3,
          reps: 6,
          rest: "120s",
          instructions: "Keep back straight",
        ),
        const Exercise(
          name: "Leg Press",
          sets: 3,
          reps: 10,
          rest: "60s",
          instructions: "Don't lock knees",
        ),
        const Exercise(
          name: "Lunges",
          sets: 3,
          reps: 10,
          rest: "60s",
          instructions: "Controlled movement",
        ),
        const Exercise(
          name: "Calf Raises",
          sets: 4,
          reps: 15,
          rest: "45s",
          instructions: "Full range of motion",
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.isFemale ? "Female Workouts" : "Male Workouts",
          style: TextStyle(color: primaryColor),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: Column(
        children: [
          _buildMuscleGroupSelector(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: workouts.length,
              onPageChanged: (index) => setState(() => selectedIndex = index),
              itemBuilder: (context, index) {
                return WorkoutCard(
                  workout: workouts[index],
                  primaryColor: primaryColor,
                  secondaryColor: secondaryColor,
                  onPressed: () => _navigateToDetail(context, index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleGroupSelector() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: muscleGroups.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Colors.grey.shade800, Colors.grey.shade700],
                      ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    muscleGroups[index].icon,
                    color: isSelected ? Colors.white : Colors.grey.shade400,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    muscleGroups[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade400,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToDetail(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutDetailScreen(
          workout: workouts[index],
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          userId: widget.userId,
          firestore: _firestore,
        ),
      ),
    );
  }
}

class WorkoutDetailScreen extends StatefulWidget {
  final WorkoutModel workout;
  final Color primaryColor;
  final Color secondaryColor;
  final String userId;
  final FirebaseFirestore firestore;

  const WorkoutDetailScreen({
    super.key,
    required this.workout,
    required this.primaryColor,
    required this.secondaryColor,
    required this.userId,
    required this.firestore,
  });

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  Future<void> _logWorkoutCompletion() async {
    try {
      if (widget.userId.isEmpty) throw Exception('User ID is empty');
      if (widget.workout.id.isEmpty) throw Exception('Workout ID is empty');

      await widget.firestore
          .collection('users')
          .doc(widget.userId)
          .collection('workouts')
          .add({
        'workoutId': widget.workout.id,
        'workoutName': widget.workout.title,
        'date': FieldValue.serverTimestamp(),
        'duration': widget.workout.duration,
        'calories': widget.workout.calories,
        'completed': true,
      });

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${widget.workout.title} completed!'),
            backgroundColor: widget.primaryColor,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error logging workout: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to log workout: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.workout.title,
          style: TextStyle(color: widget.primaryColor),
        ),
        iconTheme: IconThemeData(color: widget.primaryColor),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    widget.workout.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade900,
                      child: const Icon(Icons.fitness_center, size: 50),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDetailChip(
                        icon: Icons.timer_outlined,
                        value: widget.workout.duration,
                        label: "Duration",
                      ),
                      _buildDetailChip(
                        icon: Icons.local_fire_department_outlined,
                        value: widget.workout.calories,
                        label: "Calories",
                      ),
                      _buildDetailChip(
                        icon: Icons.fitness_center_outlined,
                        value: "${widget.workout.exercises.length}",
                        label: "Exercises",
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.workout.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Exercises",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildExerciseItem(
                widget.workout.exercises[index],
                index,
              ),
              childCount: widget.workout.exercises.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _logWorkoutCompletion,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
            shadowColor: widget.primaryColor.withOpacity(0.4),
          ),
          child: const Text(
            "COMPLETE WORKOUT",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailChip({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [widget.primaryColor, widget.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseItem(Exercise exercise, int index) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade900,
            Colors.grey.shade800,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  widget.primaryColor.withOpacity(0.3),
                  widget.secondaryColor.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildExerciseDetail(
                      "${exercise.sets} sets",
                      Icons.repeat,
                    ),
                    const SizedBox(width: 16),
                    _buildExerciseDetail(
                      exercise.reps.toString(),
                      Icons.format_list_numbered,
                    ),
                    const SizedBox(width: 16),
                    _buildExerciseDetail(
                      exercise.rest,
                      Icons.timer_outlined,
                    ),
                  ],
                ),
                if (exercise.instructions != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    exercise.instructions!,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                  ),
                ]
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDetail(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: widget.primaryColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
