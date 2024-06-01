import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      color: getBackgroundColor(3),

      child: Center(

        
      ),
    

      ),

    );
  }

Color getBackgroundColor(double score) {
    final colors = [
      Color.fromARGB(212, 231, 62, 62), // Less saturated red
      Color.fromARGB(170, 255, 166, 0), // Less saturated orange
      Color(0xfff5f500),  // Less saturated yellow
      Color(0xffd2ff92),  // Less saturated greenish yellow
      Color.fromARGB(121, 0, 255, 34),   // Less saturated green
    ];

    final ratios = [0.0, 0.25, 0.5, 0.75, 1.0]; // Score thresholds for each color

    for (int i = 0; i < ratios.length - 1; i++) {
      final lowerRatio = ratios[i];
      final upperRatio = ratios[i + 1];
      if (score >= 100.0 * lowerRatio && score < 100.0 * upperRatio) {
        final ratioWithinRange = (score - 100.0 * lowerRatio) / (100.0 * (upperRatio - lowerRatio));
        return Color.lerp(colors[i], colors[i + 1], ratioWithinRange)!;
      }
    }

    // Default to green if score is 100 or above
    return colors.last;
  }
}