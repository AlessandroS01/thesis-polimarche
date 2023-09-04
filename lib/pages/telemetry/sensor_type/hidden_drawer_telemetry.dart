import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:polimarche/model/sensor/current_model.dart';
import 'package:polimarche/model/sensor/load_model.dart';
import 'package:polimarche/model/sensor/position_model.dart';
import 'package:polimarche/model/sensor/pressure_model.dart';
import 'package:polimarche/model/sensor/speed_model.dart';
import 'package:polimarche/model/sensor/voltage_model.dart';
import 'package:polimarche/pages/telemetry/sensor_type/current/current_page.dart';
import 'package:polimarche/pages/telemetry/sensor_type/load/load_page.dart';
import 'package:polimarche/pages/telemetry/sensor_type/position/position_page.dart';
import 'package:polimarche/pages/telemetry/sensor_type/pressure/pressure_page.dart';
import 'package:polimarche/pages/telemetry/sensor_type/speed/speed_page.dart';
import 'package:polimarche/pages/telemetry/sensor_type/temperature/temperature_page.dart';
import 'package:polimarche/pages/telemetry/sensor_type/voltage/voltage_page.dart';

import '../../../model/sensor/temperature_model.dart';

class HiddenDrawerTelemetry extends StatefulWidget {
  final List<Current> currentList;
  final List<Load> loadList;
  final List<Position> positionList;
  final List<Pressure> pressureList;
  final List<Speed> speedList;
  final List<Temperature> temperatureList;
  final List<Voltage> voltageList;

  const HiddenDrawerTelemetry(
      {super.key,
      required this.temperatureList,
      required this.currentList,
      required this.loadList,
      required this.positionList,
      required this.pressureList,
      required this.speedList,
      required this.voltageList});

  @override
  State<HiddenDrawerTelemetry> createState() => _HiddenDrawerTelemetryState();
}

class _HiddenDrawerTelemetryState extends State<HiddenDrawerTelemetry> {
  final backgroundColorMenu = Colors.grey.shade700;
  final backgroundColor = Colors.grey.shade300;

  final TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Corrente',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          CurrentPage(
            currentList: widget.currentList,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Carico',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          LoadPage(
            loadList: widget.loadList,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Posizione',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          PositionPage(
            positionList: widget.positionList,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Pressione',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          PressurePage(
            pressureList: widget.pressureList,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Velocità',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          SpeedPage(
            speedList: widget.speedList,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Temperatura',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          TemperaturePage(
            temperatureList: widget.temperatureList,
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Voltaggio',
              baseStyle: textStyle,
              selectedStyle: textStyle,
              colorLineSelected: Colors.white),
          VoltagePage(
            voltageList: widget.voltageList,
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      actionsAppBar: [
        Listener(
          onPointerDown: (_) => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        )
      ],
      leadingAppBar: Icon(
        Icons.menu,
        color: Colors.black,
      ),
      slidePercent: 70,
      isTitleCentered: true,
      styleAutoTittleName: TextStyle(color: Colors.black),
      backgroundColorAppBar: Colors.grey.shade300,
      elevationAppBar: 0,
      screens: _pages,
      backgroundColorMenu: backgroundColorMenu,
      initPositionSelected: 0,
      boxShadow: [
        BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: Offset(-5, -5),
            blurRadius: 40)
      ],
    );
  }
}
