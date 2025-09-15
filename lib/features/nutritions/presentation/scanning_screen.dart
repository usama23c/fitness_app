import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'nutrition_screen.dart';

class ScanningScreen extends StatefulWidget {
  final String item;
  final String quantity;

  const ScanningScreen({
    super.key,
    required this.item,
    required this.quantity,
  });

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _linePosition;
  bool _scanningDone = false;
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _startScanningProcess();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _linePosition = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.repeat(reverse: true);
  }

  void _startScanningProcess() {
    // Simulate scanning progress
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progressValue >= 1.0) {
        timer.cancel();
        _controller.stop();
        setState(() => _scanningDone = true);
      } else {
        setState(() => _progressValue += 0.05);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNutritionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NutritionScreen(
          item: widget.item,
          quantity: widget.quantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppImages.foodScanBackground1,
              fit: BoxFit.cover,
            ),
          ),

          // App Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Analyzing ${widget.item}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {},
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),

          // Scanning Area
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Scanning Line Animation
                  AnimatedBuilder(
                    animation: _linePosition,
                    builder: (context, child) {
                      return Positioned(
                        top: _linePosition.value *
                            MediaQuery.of(context).size.height *
                            0.5,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Center crosshair
                  Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Progress Indicator
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Colors.white.withOpacity(0.2),
                color: AppColors.primary,
                minHeight: 6,
              ),
            ),
          ),

          // Bottom Button
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Text(
                  _scanningDone
                      ? "Analysis complete!"
                      : "Scanning ${widget.item}...",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _scanningDone ? _navigateToNutritionScreen : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _scanningDone
                          ? AppColors.primary
                          : Colors.grey.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _scanningDone ? "VIEW RESULTS" : "SCANNING",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (_scanningDone) ...[
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
