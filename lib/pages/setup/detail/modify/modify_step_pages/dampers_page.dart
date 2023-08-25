import 'package:flutter/material.dart';
import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/services/setup_service.dart';

import '../../../../../model/Damper.dart';

class DampersPage extends StatefulWidget {
  final List<Damper> dampers;
  final void Function(List<Damper> listDampers) updateModifySetupPage;
  final SetupService setupService;

  const DampersPage({super.key, required this.dampers, required this.updateModifySetupPage, required this.setupService});

  @override
  State<DampersPage> createState() => _DampersPageState();
}

class _DampersPageState extends State<DampersPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Ammortizzatori"),
    );
  }
}
