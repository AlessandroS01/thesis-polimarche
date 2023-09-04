import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:polimarche/model/sensor/current_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CurrentPage extends StatefulWidget {
  final List<Current> currentList;

  const CurrentPage({super.key, required this.currentList});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  final backgroundColor = Colors.grey.shade300;

  late List<Current> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.currentList;
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
            StackedLineSeries<Current, int>(
                dataSource: chartData,
                xValueMapper: (Current curr, _) => curr.id,
                yValueMapper: (Current curr, _) => curr.bpCurrent,
                name: "Bp current",
                markerSettings: MarkerSettings(isVisible: true)),
            StackedLineSeries<Current, int>(
                dataSource: chartData,
                xValueMapper: (Current curr, _) => curr.id,
                yValueMapper: (Current curr, _) => curr.coolingFanSys,
                name: "Cooling fan sys",
                markerSettings: MarkerSettings(isVisible: true)),
            StackedLineSeries<Current, int>(
                dataSource: chartData,
                xValueMapper: (Current curr, _) => curr.id,
                yValueMapper: (Current curr, _) => curr.lvBattery,
                name: "Lv battery",
                markerSettings: MarkerSettings(isVisible: true)),
            StackedLineSeries<Current, int>(
                dataSource: chartData,
                xValueMapper: (Current curr, _) => curr.id,
                yValueMapper: (Current curr, _) => curr.waterPump,
                name: "Water pump",
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
