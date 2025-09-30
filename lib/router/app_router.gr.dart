// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:funny_flutter/screens/analytics_screen.dart' as _i1;
import 'package:funny_flutter/screens/charts_screen.dart' as _i2;
import 'package:funny_flutter/screens/dashboard_screen.dart' as _i3;
import 'package:funny_flutter/screens/home_screen.dart' as _i4;
import 'package:funny_flutter/screens/profile_screen.dart' as _i5;
import 'package:funny_flutter/screens/reports_screen.dart' as _i6;
import 'package:funny_flutter/screens/settings_screen.dart' as _i7;
import 'package:funny_flutter/screens/statistics_screen.dart' as _i8;

/// generated route for
/// [_i1.AnalyticsScreen]
class AnalyticsRoute extends _i9.PageRouteInfo<AnalyticsRouteArgs> {
  AnalyticsRoute({
    _i10.Key? key,
    String? initialRouteName,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         AnalyticsRoute.name,
         args: AnalyticsRouteArgs(key: key, initialRouteName: initialRouteName),
         initialChildren: children,
       );

  static const String name = 'AnalyticsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AnalyticsRouteArgs>(
        orElse: () => const AnalyticsRouteArgs(),
      );
      return _i1.AnalyticsScreen(
        key: args.key,
        initialRouteName: args.initialRouteName,
      );
    },
  );
}

class AnalyticsRouteArgs {
  const AnalyticsRouteArgs({this.key, this.initialRouteName});

  final _i10.Key? key;

  final String? initialRouteName;

  @override
  String toString() {
    return 'AnalyticsRouteArgs{key: $key, initialRouteName: $initialRouteName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AnalyticsRouteArgs) return false;
    return key == other.key && initialRouteName == other.initialRouteName;
  }

  @override
  int get hashCode => key.hashCode ^ initialRouteName.hashCode;
}

/// generated route for
/// [_i2.ChartsScreen]
class ChartsRoute extends _i9.PageRouteInfo<void> {
  const ChartsRoute({List<_i9.PageRouteInfo>? children})
    : super(ChartsRoute.name, initialChildren: children);

  static const String name = 'ChartsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChartsScreen();
    },
  );
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute({List<_i9.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.ProfileScreen]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i6.ReportsScreen]
class ReportsRoute extends _i9.PageRouteInfo<void> {
  const ReportsRoute({List<_i9.PageRouteInfo>? children})
    : super(ReportsRoute.name, initialChildren: children);

  static const String name = 'ReportsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.ReportsScreen();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i9.PageRouteInfo<void> {
  const SettingsRoute({List<_i9.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i8.StatisticsScreen]
class StatisticsRoute extends _i9.PageRouteInfo<void> {
  const StatisticsRoute({List<_i9.PageRouteInfo>? children})
    : super(StatisticsRoute.name, initialChildren: children);

  static const String name = 'StatisticsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.StatisticsScreen();
    },
  );
}
