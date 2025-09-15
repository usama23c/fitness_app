import 'dart:math';
import 'package:fitness_app/features/activities/presentation/gender_selection_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SFPro'),
      home: const FitnessRatingScreen(),
    );
  }
}

class FitnessRatingScreen extends StatefulWidget {
  const FitnessRatingScreen({super.key});

  @override
  State<FitnessRatingScreen> createState() => _FitnessRatingScreenState();
}

class _FitnessRatingScreenState extends State<FitnessRatingScreen> {
  double angle = pi / 4;
  int rating = 3;

  String getFitnessLabel(int value) {
    if (value <= 2) return 'Beginner';
    if (value <= 4) return 'Somewhat Athletic';
    if (value <= 7) return 'Athletic';
    return 'Very Fit';
  }

  void _updateRating(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    double newAngle = atan2(dy, dx);

    if (newAngle < -pi / 2) newAngle = -pi / 2;
    if (newAngle > 0) newAngle = 0;

    setState(() {
      angle = newAngle;
      final normalized = (angle + pi / 2) / (pi / 2);
      rating = (normalized * 10).clamp(0, 10).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFF3F4F6),
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Assessment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EBF1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '3 of 6',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Center(
                child: Text(
                  "How would you rate\nyour fitness level?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.drag_indicator, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Drag to adjust",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      RenderBox box = context.findRenderObject() as RenderBox;
                      _updateRating(details.localPosition, box.size);
                    },
                    child: CustomPaint(
                      painter: SemiCircularSliderPainter(angle),
                      size: const Size(250, 150),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$rating',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  getFitnessLabel(rating),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GenderSelectionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue →',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class SemiCircularSliderPainter extends CustomPainter {
  final double angle;
  SemiCircularSliderPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 10;

    final paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final activePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final handlePaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // Background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      pi / 2,
      false,
      paint,
    );

    // Active arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      angle + pi / 2,
      false,
      activePaint,
    );

    // Handle
    final handleX = center.dx + radius * cos(angle);
    final handleY = center.dy + radius * sin(angle);
    canvas.drawCircle(Offset(handleX, handleY), 14, handlePaint);
  }

  @override
  bool shouldRepaint(covariant SemiCircularSliderPainter oldDelegate) {
    return angle != oldDelegate.angle;
  }
}
