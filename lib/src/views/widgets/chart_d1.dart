import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guide/src/controllers/index.dart';
import 'package:guide/src/models/index.dart';
import 'package:intl/intl.dart';

class ChartD1 extends StatefulWidget {
  final FinanceModel finance;
  const ChartD1({super.key, required this.finance});

  @override
  State<ChartD1> createState() => _ChartD1State();
}

class _ChartD1State extends State<ChartD1> {
  final controller = Get.put(HomeController());

  late List<FlSpot> spots = [];

  double maxAxisY = 0.0;
  double minAxisY = 0.0;

  @override
  void initState() {
    super.initState();

    double? lastPrice;

    for (int index = 0; index < widget.finance.indicators!.open!.length; index++) {
      final price = widget.finance.indicators!.open![index];

      final variance = controller.variance(price, lastPrice) ?? 0.0;

      maxAxisY = max(maxAxisY, variance);
      minAxisY = min(minAxisY, variance);

      spots.add(FlSpot(index + .0, controller.variance(price, lastPrice) ?? 0.0));

      lastPrice = price;
    }
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    if (value % 5 != 0) {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
          '${DateFormat('dd/MM').format(DateTime.fromMillisecondsSinceEpoch(widget.finance.timestamp![value.toInt()] * 1000))} '),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(
        meta.formattedValue,
        //style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        bottom: 12,
        right: 20,
        top: 20,
      ),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    maxContentWidth: 150,
                    tooltipBgColor: Colors.black,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((LineBarSpot touchedSpot) {
                        const textStyle = TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        return LineTooltipItem(
                            '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.finance.timestamp![touchedSpot.x.toInt()] * 1000))} - Variação de ${touchedSpot.y.toStringAsFixed(2)}%',
                            textStyle);
                      }).toList();
                    },
                  ),
                  handleBuiltInTouches: true,
                  getTouchLineStart: (data, index) => 0,
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: Colors.black45,
                    spots: spots,
                    isCurved: true,
                    isStrokeCapRound: true,
                    barWidth: 2,
                    belowBarData: BarAreaData(show: false),
                    dotData: FlDotData(show: true),
                  ),
                ],
                minY: minAxisY,
                maxY: maxAxisY,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, constraints.maxWidth),
                      reservedSize: 56,
                    ),
                    drawBehindEverything: true,
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, constraints.maxWidth),
                      reservedSize: 36,
                      interval: 1,
                    ),
                    drawBehindEverything: false,
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                  horizontalInterval: 7.5,
                  verticalInterval: 5,
                  checkToShowHorizontalLine: (value) {
                    return value.toInt() == 0;
                  },
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: Colors.blueAccent.withOpacity(1),
                    dashArray: [8, 2],
                    strokeWidth: 0.8,
                  ),
                  getDrawingVerticalLine: (_) => FlLine(
                    color: Colors.pinkAccent.withOpacity(1),
                    dashArray: [8, 2],
                    strokeWidth: 0.8,
                  ),
                  checkToShowVerticalLine: (value) {
                    return value.toInt() == 0;
                  },
                ),
                borderData: FlBorderData(show: false),
              ),
            );
          },
        ),
      ),
    );
  }
}
