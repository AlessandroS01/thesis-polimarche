import 'package:flutter/material.dart';
import 'package:polimarche/model/member_model.dart';

class AuthorizationProvider extends InheritedWidget {
  final Member loggedMember;

  const AuthorizationProvider({
    Key? key,
    required Widget child,
    required this.loggedMember,
  }) : super(key: key, child: child);

  static AuthorizationProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AuthorizationProvider>();

  @override
  bool updateShouldNotify(AuthorizationProvider old) =>
      old.loggedMember != loggedMember;
}
