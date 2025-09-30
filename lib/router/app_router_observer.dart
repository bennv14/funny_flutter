import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppRouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('xxxx [ROUTE] Push: ${route.settings.name}');
      if (previousRoute != null) {
        print('xxxx   ← From: ${previousRoute.settings.name}');
      }
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('xxxx  [ROUTE] Pop: ${route.settings.name}');
      if (previousRoute != null) {
        print('xxxx   → To: ${previousRoute.settings.name}');
      }
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (kDebugMode) {
      print('xxxx [ROUTE] Replace: ${newRoute?.settings.name} -> ${oldRoute?.settings.name}');
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (kDebugMode) {
      print('xxxx [ROUTE] Remove: ${route.settings.name}');
      if (previousRoute != null) {
        print('xxxx   → To: ${previousRoute.settings.name}');
      }
    }
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    if (kDebugMode) {
      print('xxxx [TAB] Init: ${route.name}');
      if (previousRoute != null) {
        print('xxxx   ← From: ${previousRoute.name}');
      }
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    if (kDebugMode) {
      print('xxxx [TAB] Change: ${route.name} -> ${previousRoute.name}');
    }
  }
}
