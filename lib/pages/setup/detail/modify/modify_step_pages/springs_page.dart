import 'package:flutter/material.dart';
import 'package:polimarche/services/setup_service.dart';

import '../../../../../model/Spring.dart';

class SpringsPage extends StatefulWidget {
  final List<Spring> springs;
  final void Function(List<Spring> listSprings) updateModifySetupPage;
  final SetupService setupService;

  const SpringsPage({super.key, required this.springs, required this.updateModifySetupPage, required this.setupService});

  @override
  State<SpringsPage> createState() => _SpringsPageState();
}

class _SpringsPageState extends State<SpringsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Molle"),
    );
  }
}
