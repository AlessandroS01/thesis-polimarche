import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:polimarche/model/sensor/load_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoadPage extends StatefulWidget {
  final List<Load> loadList;

  const LoadPage({super.key, required this.loadList});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  final backgroundColor = Colors.grey.shade300;

  late List<Load> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.loadList;
    chartData.sort((a, b) => a.id!.compareTo(b.id!));

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Column(
            children: [
              Center(
                child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  series: <ChartSeries>[
                    StackedLineSeries<Load, int>(
                        dataSource: chartData,
                        xValueMapper: (Load load, _) => load.id,
                        yValueMapper: (Load load, _) => load.pushFL,
                        name: "Push FL",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Load, int>(
                        dataSource: chartData,
                        xValueMapper: (Load load, _) => load.id,
                        yValueMapper: (Load load, _) => load.pushFR,
                        name: "Push FR",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Load, int>(
                        dataSource: chartData,
                        xValueMapper: (Load load, _) => load.id,
                        yValueMapper: (Load load, _) => load.pushRR,
                        name: "Push RR",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Load, int>(
                        dataSource: chartData,
                        xValueMapper: (Load load, _) => load.id,
                        yValueMapper: (Load load, _) => load.pushRL,
                        name: "Push RL",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Load, int>(
                        dataSource: chartData,
                        xValueMapper: (Load load, _) => load.id,
                        yValueMapper: (Load load, _) => load.steerTorque,
                        name: "Steer torque",
                        markerSettings: MarkerSettings(isVisible: true)),
                  ],
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true, // Enable pinch zoom
                    enableDoubleTapZooming: true, // Enable double-tap zooming
                    enablePanning: true, // Enable panning/move behavior
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
