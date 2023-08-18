import 'package:flutter/material.dart';
import 'package:polimarche/services/note_service.dart';


// inherited widget
class AgendaInheritedState extends InheritedWidget {
  final NoteService noteService;

  AgendaInheritedState({
    required Widget child,
    required this.noteService
  }) : super(child: child);


  static AgendaInheritedState? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<AgendaInheritedState>();


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) =>
      noteService != (oldWidget as AgendaInheritedState).noteService;
}
