import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/common/common.dart';

@immutable
class RoutesConfig {
  static final navigationKey = GlobalKey<NavigatorState>();
  static final routeConfig = GoRouter(
    initialLocation: '/createdByYou',
    navigatorKey: navigationKey,
    routes: routes,
  );
}
