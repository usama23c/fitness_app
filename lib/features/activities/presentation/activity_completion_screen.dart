import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityCompletionScreen extends StatelessWidget {
  final String activityType;
  final double distance;
  final Duration duration;
  final double calories;
  final List<int> bpmHistory;

  const ActivityCompletionScreen({
    super.key,
    required this.activityType,
    required this.distance,
    required this.duration,
    required this.calories,
    required this.bpmHistory,
  });

  String _formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  double _calculateProgress() {
    const targetDistance = 5.0; // 5km target
    return (distance / targetDistance).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final progress = _calculateProgress();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                '$activityType Completed!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Main progress indicator
              CircularPercentIndicator(
                radius: 120,
                lineWidth: 15,
                percent: progress,
                center: Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(fontSize: 24),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.grey,
                progressColor: AppColors.primary,
              ),
              const SizedBox(height: 30),

              // Stats grid
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildStatCard(
                    icon: Icons.directions_run,
                    value: '${distance.toStringAsFixed(2)} km',
                    label: 'Distance',
                  ),
                  _buildStatCard(
                    icon: Icons.timer,
                    value: _formatDuration(),
                    label: 'Duration',
                  ),
                  _buildStatCard(
                    icon: Icons.local_fire_department,
                    value: '${calories.toStringAsFixed(1)} kcal',
                    label: 'Calories',
                  ),
                  _buildStatCard(
                    icon: Icons.favorite,
                    value:
                        '${bpmHistory.isNotEmpty ? bpmHistory.reduce((a, b) => a + b) ~/ bpmHistory.length : 0} avg',
                    label: 'BPM',
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // BPM chart
              SizedBox(
                height: 200,
                child: bpmHistory.isEmpty
                    ? const Center(child: Text("No heart rate data available"))
                    : LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: bpmHistory.length.toDouble() - 1,
                          minY: bpmHistory
                                  .reduce((a, b) => a < b ? a : b)
                                  .toDouble() -
                              10,
                          maxY: bpmHistory
                                  .reduce((a, b) => a > b ? a : b)
                                  .toDouble() +
                              10,
                          lineBarsData: [
                            LineChartBarData(
                              spots: bpmHistory.asMap().entries.map((e) {
                                return FlSpot(
                                    e.key.toDouble(), e.value.toDouble());
                              }).toList(),
                              isCurved: true,
                              color: AppColors.primary,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 20),

              // Finish button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
