import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../model/sensor/voltage_model.dart';

class VoltagePage extends StatefulWidget {
  final List<Voltage> voltageList;

  const VoltagePage({super.key, required this.voltageList});

  @override
  State<VoltagePage> createState() => _VoltagePageState();
}

class _VoltagePageState extends State<VoltagePage> {
  final backgroundColor = Colors.grey.shade300;

  late List<Voltage> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.voltageList;
    chartData.sort((a, b) => a.id!.compareTo(b.id!));

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          margin: EdgeInsets.fromLTRB(40, 10, 40, 40),
          child: Column(
            children: [
              Center(
                child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  series: <ChartSeries>[
                    StackedLineSeries<Voltage, int>(
                        dataSource: chartData,
                        xValueMapper: (Voltage volt, _) => volt.id,
                        yValueMapper: (Voltage volt, _) => volt.lvBattery,
                        name: "Lv battery",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Voltage, int>(
                        dataSource: chartData,
                        xValueMapper: (Voltage volt, _) => volt.id,
                        yValueMapper: (Voltage volt, _) => volt.source24v,
                        name: "Source24v",
                        markerSettings: MarkerSettings(isVisible: true)),
                    StackedLineSeries<Voltage, int>(
                        dataSource: chartData,
                        xValueMapper: (Voltage volt, _) => volt.id,
                        yValueMapper: (Voltage volt, _) => volt.source5v,
                        name: "source5v",
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
