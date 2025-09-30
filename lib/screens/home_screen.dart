import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../router/app_router.gr.dart';
import '../blocs/home/home_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeEvent.initialize()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return AutoTabsScaffold(
            routes: const [DashboardRoute(), ProfileRoute(), SettingsRoute()],
            appBarBuilder: (context, tabsRouter) => AppBar(
              title: const Text('Auto Route Nested Demo'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Text(
                      'Tab: ${state.currentTabIndex + 1}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBuilder: (context, tabsRouter) {
              return NavigationBar(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: (index) {
                  tabsRouter.setActiveIndex(index);
                  context.read<HomeBloc>().add(HomeEvent.changeTab(index));
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
  
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeEvent.initialize()),
      child: this,
    );
    
  }
}
