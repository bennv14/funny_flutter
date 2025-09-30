import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: DashboardRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
            AutoRoute(
              page: SettingsRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: AnalyticsRoute.page,
          children: [
            AutoRoute(
              page: ChartsRoute.page,
              initial: true,
            ),
            AutoRoute(
              page: ReportsRoute.page,
            ),
            AutoRoute(
              page: StatisticsRoute.page,
            ),
          ],
        ),
      ];
}
