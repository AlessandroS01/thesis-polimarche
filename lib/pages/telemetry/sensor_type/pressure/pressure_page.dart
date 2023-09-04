import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../model/sensor/pressure_model.dart';

class PressurePage extends StatefulWidget {
  final List<Pressure> pressureList;

  const PressurePage({super.key, required this.pressureList});

  @override
  State<PressurePage> createState() => _PressurePageState();
}

class _PressurePageState extends State<PressurePage> {
  final backgroundColor = Colors.grey.shade300;

  late List<Pressure> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.pressureList;
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
                    StackedLineSeries<Pressure, int>(
                        dataSource: chartData,
                        xValueMapper: (Pressure press, _) => press.id,
                        yValueMapper: (Pressure press, _) => press.brakeF,
                        name: "Brake F",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Pressure, int>(
                        dataSource: chartData,
                        xValueMapper: (Pressure press, _) => press.id,
                        yValueMapper: (Pressure press, _) => press.brakeR,
                        name: "Brake R",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Pressure, int>(
                        dataSource: chartData,
                        xValueMapper: (Pressure press, _) => press.id,
                        yValueMapper: (Pressure press, _) => press.coolant,
                        name: "Coolant",
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
