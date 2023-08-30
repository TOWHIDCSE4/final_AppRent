import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

enum DataChartType { deposit, withdraw, silver, gold }

class DataChart extends StatelessWidget {
  const DataChart({super.key, this.type = DataChartType.deposit});

  final DataChartType type;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return 'T1';
                case 2:
                  return 'T2';
                case 3:
                  return 'T3';
                case 4:
                  return 'T4';
                case 5:
                  return 'T5';
                case 6:
                  return 'T6';
                case 7:
                  return 'T7';
                case 8:
                  return 'T8';
                case 9:
                  return 'T9';
                case 10:
                  return 'T10';
                case 11:
                  return 'T11';
                case 12:
                  return 'T12';
                default:
                  return '';
              }
            },
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              switch (value.toInt()) {
                case 1:
                  return '1';
                case 2:
                  return '2';
                case 3:
                  return '3';
                case 4:
                  return '4';
                case 5:
                  return '5';
                case 6:
                  return '6';
                case 7:
                  return '7';
                default:
                  return '';
              }
            },
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
              left: BorderSide(color: Color(0xff37434d), width: 1),
              bottom: BorderSide(color: Color(0xff37434d), width: 1)),
        ),
        minX: 1,
        maxX: 12,
        minY: 1,
        maxY: 7,
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(1, 1.9),
              FlSpot(2, 2.3),
              FlSpot(3, 2.5),
              FlSpot(4, 2.7),
              FlSpot(5, 2.9),
              FlSpot(6, 3),
              FlSpot(7, 3.5),
              FlSpot(8, 4),
              FlSpot(9, 6.3),
              FlSpot(10, 4.3),
              FlSpot(11, 4.5),
              FlSpot(12, 4.9),
            ],
            isCurved: false,
            colors: [
              type == DataChartType.withdraw
                  ? const Color(0xFFFF0000)
                  : type == DataChartType.gold
                      ? const Color(0xFFFFC774)
                      : type == DataChartType.silver
                          ? const Color(0xFF8E8E8E)
                          : const Color(0xFF11DF57)
            ],
          ),
        ],
      ),
    );
  }
}