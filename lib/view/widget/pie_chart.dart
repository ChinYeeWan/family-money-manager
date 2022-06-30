import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/category_data.dart';

class PieChart extends StatelessWidget {
  const PieChart({
    Key key,
    @required TooltipBehavior tooltipBehavior,
    @required List<CategoryData> chartData,
    @required double total,
  })  : _tooltipBehavior = tooltipBehavior,
        _chartData = chartData,
        _total = total,
        super(key: key);

  final TooltipBehavior _tooltipBehavior;
  final List<CategoryData> _chartData;
  final double _total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.right,
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<CategoryData, String>(
                dataSource: _chartData,
                xValueMapper: (CategoryData data, _) => data.category.name,
                yValueMapper: (CategoryData data, _) => data.amount,
                //Map color
                pointColorMapper: (CategoryData data, _) =>
                    Color(data.category.color).withOpacity(0.2),
                dataLabelMapper: (CategoryData data, _) =>
                    calculatePercentage(data.amount, _total)
                        .toStringAsFixed(1) +
                    " %",
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelIntersectAction: LabelIntersectAction.shift,
                ),
              ),
            ]),
      ),
    );
  }

  double calculatePercentage(amount, total) {
    return amount * 100 / total;
  }
}
