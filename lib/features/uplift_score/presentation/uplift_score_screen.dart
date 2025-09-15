import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class UpliftScoreScreen extends StatelessWidget {
  const UpliftScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Text(
                    'Uplift Score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Donut Chart
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  startDegreeOffset: 180,
                  sections: [
                    PieChartSectionData(
                      color: Colors.deepOrangeAccent,
                      value: 26,
                      title: '26%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.black87,
                      value: 54,
                      title: '54%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.deepPurpleAccent,
                      value: 24,
                      title: '24%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Score
            const Text(
              '88',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You are a healthy individual',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // Legend
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LegendDot(color: Colors.deepOrangeAccent, label: 'Strength'),
                SizedBox(width: 16),
                LegendDot(color: Colors.black87, label: 'Agility'),
                SizedBox(width: 16),
                LegendDot(color: Colors.deepPurpleAccent, label: 'Endurance'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Legend Dot Widget
class LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const LegendDot({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
