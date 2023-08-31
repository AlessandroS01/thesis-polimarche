import 'package:flutter/material.dart';

import '../services/session_service.dart';

class SessionInheritedState extends InheritedWidget {
  final SessionService sessionService;

  SessionInheritedState({required Widget child, required this.sessionService})
      : super(child: child);

  static SessionInheritedState? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SessionInheritedState>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      sessionService != (oldWidget as SessionInheritedState).sessionService;
}
