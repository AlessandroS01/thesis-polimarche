import 'package:flutter/material.dart';
import 'package:polimarche/services/note_service.dart';
import 'package:polimarche/services/team_service.dart';

class TeamInheritedState extends InheritedWidget {
  final TeamService teamService;

  const TeamInheritedState({required Widget child, required this.teamService})
      : super(child: child);

  static TeamInheritedState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TeamInheritedState>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      teamService != (oldWidget as TeamInheritedState).teamService;
}
