import 'package:flutter/material.dart';
import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/services/setup_service.dart';

import '../../../../../model/Balance.dart';

class BalancePage extends StatefulWidget {
  final List<Balance> balances;
  final void Function(List<Balance> listBalances) updateModifySetupPage;
  final SetupService setupService;

  const BalancePage({super.key, required this.balances, required this.updateModifySetupPage, required this.setupService});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Bilanciamento"),
    );
  }
}
