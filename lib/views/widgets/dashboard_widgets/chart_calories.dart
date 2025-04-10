import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardCaloriesChart extends StatelessWidget {
  final List<FlSpot> listCaloriesTarget;
  final List<FlSpot> listCaloriesActual;
  const DashboardCaloriesChart({super.key, required this.listCaloriesActual, required this.listCaloriesTarget});


  @override
  Widget build(BuildContext context) {
    final maxY = listCaloriesTarget.map((e) => e.y).fold<double>(0, (prev, curr) => curr > prev ? curr : prev);
    final interval = maxY > 2000 ? 500.0 : 250.0;
    final maxAxisValue = ((maxY / interval).ceil() + 1) * interval;

    final yTicks = <double>[];
    for (double i = interval; i <= maxAxisValue; i += interval) {
      yTicks.add(i);
    }

    return Stack(
      children: [
        LineChart(
          LineChartData(
            minY: 0,
            maxY: maxAxisValue,
            maxX: 6,
            gridData: FlGridData(show: true ,drawVerticalLine: true, drawHorizontalLine: false),
            borderData: FlBorderData(show: true,
            border: Border.all(
              color: colorPrimary800,
              width: 2,
            )),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    final index = value.toInt();
                    if (index >= 0 && index < days.length) {
                      return Text(days[index], style: TextThemeStyle.textSecondaryFontSizeBold(12));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: interval,
                  getTitlesWidget: (value, meta) {
                    if (yTicks.contains(value)) {
                      return Text('${value.toInt()}', style: TextThemeStyle.textSecondaryFontSizeBold(12));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            lineBarsData: [
              _buildLineCaloriesTargetData(),
              _buildLineCaloriesActualData(),
            ],
            lineTouchData: LineTouchData(
              enabled: true,
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map((index) {
                  return TouchedSpotIndicatorData(
                    FlLine(color: colorPrimary), // No line
                    FlDotData(show: true),
                  );
                }).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                tooltipRoundedRadius: 10,
                tooltipPadding: const EdgeInsets.all(8),
                getTooltipColor: (touchedSpot) => Colors.white30,
                getTooltipItems: (List<LineBarSpot> touchedSpots) {

                  return touchedSpots.map((spot) {
                    final color = spot.barIndex == 0 ? Colors.red : colorPrimary;
                    return LineTooltipItem(
                      '${spot.y.toInt()}',
                       TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          )
        ),
      ],
    );
  }



  LineChartBarData _buildLineCaloriesTargetData() {
    return LineChartBarData(
      spots: listCaloriesTarget,
      isCurved: false,
      color: Colors.red,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    );
  }

  LineChartBarData _buildLineCaloriesActualData() {
    return LineChartBarData(
      spots: listCaloriesActual,
      isCurved: false,
      color: colorPrimary,
      belowBarData: BarAreaData(show: false),
      dotData: FlDotData(show: true),
    );
  }
}


