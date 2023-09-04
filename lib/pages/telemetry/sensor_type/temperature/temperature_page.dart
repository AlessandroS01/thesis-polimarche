import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../model/sensor/temperature_model.dart';

class TemperaturePage extends StatefulWidget {
  final List<Temperature> temperatureList;

  const TemperaturePage({super.key, required this.temperatureList});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final backgroundColor = Colors.grey.shade300;

  bool _visualizeMotorFirstData =
      true; // igbt, motorOne, motorTwo, inverter, module
  bool _visualizeMotorSecondaData =
      false; // pdm, coolantInt, coolantOut, mcu, vcu
  bool _visualizeGenericData = false; // air, humidity
  bool _visualizeBrakeData = false; // brake
  bool _visualizeTyreData = false; // tyre

  late List<Temperature> chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();

    chartData = widget.temperatureList;
    chartData.sort((a, b) => a.id!.compareTo(b.id!));

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 40),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Motore 1"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _visualizeMotorFirstData,
                            onChanged: (bool? value) {
                              setState(() {
                                _visualizeMotorFirstData = value!;
                                _visualizeMotorSecondaData = false;
                                _visualizeGenericData = false;
                                _visualizeBrakeData = false;
                                _visualizeTyreData = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Motore 2"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _visualizeMotorSecondaData,
                            onChanged: (bool? value) {
                              setState(() {
                                _visualizeMotorSecondaData = value!;
                                _visualizeMotorFirstData = false;
                                _visualizeGenericData = false;
                                _visualizeBrakeData = false;
                                _visualizeTyreData = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Freni"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _visualizeBrakeData,
                            onChanged: (bool? value) {
                              setState(() {
                                _visualizeBrakeData = value!;
                                _visualizeGenericData = false;
                                _visualizeMotorSecondaData = false;
                                _visualizeMotorFirstData = false;
                                _visualizeTyreData = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Gomme"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _visualizeTyreData,
                            onChanged: (bool? value) {
                              setState(() {
                                _visualizeTyreData = value!;
                                _visualizeBrakeData = false;
                                _visualizeGenericData = false;
                                _visualizeMotorSecondaData = false;
                                _visualizeMotorFirstData = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Generici"),
                          Checkbox(
                            activeColor: Colors.black,
                            value: _visualizeGenericData,
                            onChanged: (bool? value) {
                              setState(() {
                                _visualizeGenericData = value!;
                                _visualizeMotorSecondaData = false;
                                _visualizeMotorFirstData = false;
                                _visualizeBrakeData = false;
                                _visualizeTyreData = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30,),

                if(_visualizeMotorFirstData) Center(
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    legend: Legend(isVisible: true,
                    position: LegendPosition.bottom),
                    series: <ChartSeries>[
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.igbt,
                          name: "Igbt",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.motorOne,
                          name: "Motor one",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.motorTwo,
                          name: "Motor two",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.inverter,
                          name: "Inverter",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.module,
                          name: "Module",
                          markerSettings: MarkerSettings(isVisible: true)),
                    ],
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true, // Enable pinch zoom
                      enableDoubleTapZooming: true, // Enable double-tap zooming
                      enablePanning: true, // Enable panning/move behavior
                    ),
                  ),
                ),
                if(_visualizeMotorSecondaData)Center(
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    legend: Legend(isVisible: true,
                    position: LegendPosition.bottom),
                    series: <ChartSeries>[
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.pdm,
                          name: "PDM",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.motorTwo,
                          name: "Motor two",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.coolantIn,
                          name: "Coolant in",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.coolantOut,
                          name: "Coolant out",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.mcu,
                          name: "Mcu",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.vcu,
                          name: "Vcu",
                          markerSettings: MarkerSettings(isVisible: true)),
                    ],
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true, // Enable pinch zoom
                      enableDoubleTapZooming: true, // Enable double-tap zooming
                      enablePanning: true, // Enable panning/move behavior
                    ),
                  ),
                ),
                if(_visualizeGenericData)Center(
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    legend: Legend(isVisible: true,
                    position: LegendPosition.bottom),
                    series: <ChartSeries>[
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.air,
                          name: "Air",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.humidity,
                          name: "Humidity",
                          markerSettings: MarkerSettings(isVisible: true)),
                    ],
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true, // Enable pinch zoom
                      enableDoubleTapZooming: true, // Enable double-tap zooming
                      enablePanning: true, // Enable panning/move behavior
                    ),
                  ),
                ),
                if(_visualizeBrakeData)Center(
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    legend: Legend(isVisible: true,
                    position: LegendPosition.bottom),
                    series: <ChartSeries>[
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.brakeFR,
                          name: "Brake FR",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.brakeFL,
                          name: "Brake FL",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.brakeRR,
                          name: "Brake RR",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.brakeRL,
                          name: "Brake RL",
                          markerSettings: MarkerSettings(isVisible: true)),
                    ],
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePinching: true, // Enable pinch zoom
                      enableDoubleTapZooming: true, // Enable double-tap zooming
                      enablePanning: true, // Enable panning/move behavior
                    ),
                  ),
                ),
                if(_visualizeTyreData)Center(
                  child: SfCartesianChart(
                    tooltipBehavior: _tooltipBehavior,
                    legend: Legend(isVisible: true,
                    position: LegendPosition.bottom),
                    series: <ChartSeries>[
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.tyreFR,
                          name: "Tyre FR",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.tyreFL,
                          name: "Tyre FL",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.tyreRR,
                          name: "Tyre RR",
                          markerSettings: MarkerSettings(isVisible: true)),
                      StackedLineSeries<Temperature, int>(
                          dataSource: chartData,
                          xValueMapper: (Temperature temp, _) => temp.id,
                          yValueMapper: (Temperature temp, _) => temp.tyreRL,
                          name: "Tyre RL",
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
          ),
        ));
  }
}
