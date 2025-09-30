import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/analytics/analytics_bloc.dart';
import '../router/app_router.gr.dart';

@RoutePage()
class AnalyticsScreen extends StatefulWidget implements AutoRouteWrapper {
  final String? initialRouteName;

  const AnalyticsScreen({super.key, this.initialRouteName});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
  
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyticsBloc()..add(const AnalyticsEvent.initialize()),
      lazy: false,
      child: this,
    );
  }
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    final initialRoute = _getInitialRoute();
    if (initialRoute != null) {
      context.router.push(initialRoute);
    }
  }


  PageRouteInfo? _getInitialRoute() {
    switch (widget.initialRouteName) {
      case ReportsRoute.name:
        return const ReportsRoute();
      case StatisticsRoute.name:
        return const StatisticsRoute();
      case ChartsRoute.name:
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
