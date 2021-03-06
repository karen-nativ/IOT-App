import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'statsData.dart';



class GroupedBarChart extends StatelessWidget {
  final List<charts.Series<ObjectType, String>> seriesList;
  final bool animate;


  GroupedBarChart(this.seriesList, {required this.animate});

  factory GroupedBarChart.withSampleData(Data data) {
    return new GroupedBarChart(
      _createSampleData(data),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [new charts.SeriesLegend()],
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(
            labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),
      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white))),
    );
  }

  /// Create series list with multiple series
  /// ObjectType
  static List<charts.Series<ObjectType, String>> _createSampleData(Data data) {
    final TotalData = [
      new ObjectType('Face', data.face.totalTimes),
      new ObjectType('Phone', data.phone.totalTimes),
      new ObjectType('Bag', data.bag.totalTimes),
      new ObjectType('Watch', data.watch.totalTimes),
      new ObjectType('Bottle', data.bottle.totalTimes),
    ];

    final RightData = [
      new ObjectType('Face', data.face.correct),
      new ObjectType('Phone', data.phone.correct),
      new ObjectType('Bag', data.bag.correct),
      new ObjectType('Watch', data.watch.correct),
      new ObjectType('Bottle', data.bottle.correct),
    ];

    final WrongData = [
      new ObjectType('Face', data.face.wrong),
      new ObjectType('Phone', data.phone.wrong),
      new ObjectType('Bag', data.bag.wrong),
      new ObjectType('Watch', data.watch.wrong),
      new ObjectType('Bottle', data.bottle.wrong),
    ];

    return [
      new charts.Series<ObjectType, String>(
        id: 'Total',
        domainFn: (ObjectType type, _) => type.name,
        measureFn: (ObjectType type, _) => type.amount,
        data: TotalData,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.lightBlueAccent)
      ),
      new charts.Series<ObjectType, String>(
        id: 'Right',
        domainFn: (ObjectType type, _) => type.name,
        measureFn: (ObjectType type, _) => type.amount,
        data: RightData,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(const Color(0xFF6BFF90))
      ),
      new charts.Series<ObjectType, String>(
        id: 'Wrong',
        domainFn: (ObjectType type, _) => type.name,
        measureFn: (ObjectType type, _) => type.amount,
        data: WrongData,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault
      ),
    ];
  }
}

/// Sample object type.
class ObjectType {
  final String name;
  final int amount;

  ObjectType(this.name, this.amount);
}