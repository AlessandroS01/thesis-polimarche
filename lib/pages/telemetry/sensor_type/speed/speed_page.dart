import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:polimarche/model/sensor/speed_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpeedPage extends StatefulWidget {
  final List<Speed> speedList;

  const SpeedPage({super.key, required this.speedList});

  @override
  State<SpeedPage> createState() => _SpeedPageState();
}

class _SpeedPageState extends State<SpeedPage> {
  final backgroundColor = Colors.grey.shade300;

  late List<Speed> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.speedList;
    chartData.sort((a, b) => a.id!.compareTo(b.id!));

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SfCartesianChart(
          tooltipBehavior: _tooltipBehavior,
          legend:
              Legend(isVisible: true, position: LegendPosition.bottom),
          series: <ChartSeries>[
            StackedLineSeries<Speed, int>(
                dataSource: chartData,
                xValueMapper: (Speed speed, _) => speed.id,
                yValueMapper: (Speed speed, _) => speed.wheelFL,
                name: "Wheel FL",
                markerSettings: MarkerSettings(isVisible: true)),
            StackedLineSeries<Speed, int>(
                dataSource: chartData,
                xValueMapper: (Speed speed, _) => speed.id,
                yValueMapper: (Speed speed, _) => speed.wheelFR,
                name: "Wheel FR",
                markerSettings: MarkerSettings(isVisible: true)),
          ],
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true, // Enable pinch zoom
            enableDoubleTapZooming: true, // Enable double-tap zooming
            enablePanning: true, // Enable panning/move behavior
          ),
        ));
  }
}
