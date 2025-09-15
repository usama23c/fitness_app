import 'package:flutter/material.dart';

class CalorieStatsScreen extends StatelessWidget {
  const CalorieStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Calorie Stats",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text("Jan",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.grey)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text.rich(
                TextSpan(
                  text: '318',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text: ' kcal',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal))
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BarChartItem(
                        color: Colors.black, percent: 20, label: "Fat"),
                    BarChartItem(
                        color: Colors.orange, percent: 10, label: "Carbs"),
                    BarChartItem(
                        color: Colors.blue, percent: 30, label: "Protein"),
                    BarChartItem(
                        color: Colors.green, percent: 25, label: "Macro"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const CalorieInfoItem(
                  color: Colors.black, label: "Fat", grams: "201g"),
              const CalorieInfoItem(
                  color: Colors.blue, label: "Protein", grams: "201g"),
              const CalorieInfoItem(
                  color: Colors.orange, label: "Carbs", grams: "201g"),
              const CalorieInfoItem(
                  color: Colors.green, label: "Macro", grams: "201g"),
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartItem extends StatelessWidget {
  final Color color;
  final int percent;
  final String label;

  const BarChartItem({
    super.key,
    required this.color,
    required this.percent,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 160,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Container(
              height: 160 * (percent / 100),
              width: 48,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "$percent%",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
      ],
    );
  }
}

class CalorieInfoItem extends StatelessWidget {
  final Color color;
  final String label;
  final String grams;

  const CalorieInfoItem({
    super.key,
    required this.color,
    required this.label,
    required this.grams,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 12, color: color),
          const SizedBox(width: 12),
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          const Spacer(),
          Text(grams,
              style:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        ],
      ),
    );
  }
}
