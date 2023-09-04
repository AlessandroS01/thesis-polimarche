import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:polimarche/model/sensor/position_model.dart' as pos;
import 'package:syncfusion_flutter_charts/charts.dart';

class PositionPage extends StatefulWidget {
  final List<pos.Position> positionList;

  const PositionPage({super.key, required this.positionList});

  @override
  State<PositionPage> createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  final backgroundColor = Colors.grey.shade300;

  late List<pos.Position> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.positionList;
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
                    StackedLineSeries<pos.Position, int>(
                        dataSource: chartData,
                        xValueMapper: (pos.Position pos, _) => pos.id,
                        yValueMapper: (pos.Position pos, _) => pos.steeringAngle,
                        name: "Steering angle",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<pos.Position, int>(
                        dataSource: chartData,
                        xValueMapper: (pos.Position pos, _) => pos.id,
                        yValueMapper: (pos.Position pos, _) => pos.suspensionFL,
                        name: "Suspension FL",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<pos.Position, int>(
                        dataSource: chartData,
                        xValueMapper: (pos.Position pos, _) => pos.id,
                        yValueMapper: (pos.Position pos, _) => pos.suspensionFR,
                        name: "Suspension FR",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<pos.Position, int>(
                        dataSource: chartData,
                        xValueMapper: (pos.Position pos, _) => pos.id,
                        yValueMapper: (pos.Position pos, _) => pos.suspensionRL,
                        name: "Suspension RL",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<pos.Position, int>(
                        dataSource: chartData,
                        xValueMapper: (pos.Position pos, _) => pos.id,
                        yValueMapper: (pos.Position pos, _) => pos.suspensionRR,
                        name: "Suspension RR",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<pos.Position, int>(
                        dataSource: chartData,
                        xValueMapper: (pos.Position pos, _) => pos.id,
                        yValueMapper: (pos.Position pos, _) => pos.throttle,
                        name: "Throttle",
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
