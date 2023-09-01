import 'package:flutter/material.dart';
import 'package:polimarche/services/setup_service.dart';

class SetupInheritedState extends InheritedWidget {
  final SetupService setupService;

  SetupInheritedState({required Widget child, required this.setupService})
      : super(child: child);

  static SetupInheritedState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SetupInheritedState>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      setupService != (oldWidget as SetupInheritedState).setupService;
}
