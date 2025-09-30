# funny_flutter

Demo project minh họa **Auto Route** với **Nested Routes** và **Bloc State Management** trong Flutter.

## 🎯 Tổng quan

Project này demo:

- ✅ **Multiple route groups** (Home và Analytics)
- ✅ **Nested routing** với AutoTabsScaffold và AutoRouter
- ✅ **Shared state** giữa nested screens
- ✅ **Bloc pattern** cho state management
- ✅ **Navigation utilities** và debugging tools

## 🚀 Quick Start

### 1. Cài đặt dependencies

```bash
flutter pub get
```

### 2. Generate router code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Chạy app

```bash
flutter run
```

## 📱 Features

### Home Group (AutoTabsScaffold)

- 3 tabs: Dashboard, Profile, Settings
- Bottom navigation bar
- Shared counter state giữa các tabs
- Tab indicator trong AppBar

### Analytics Group (Nested Navigation)

- 3 screens: Charts, Reports, Statistics
- Push/pop navigation
- Initial route parameter support
- Navigation utilities (Home, Back)

### State Management

- **HomeBloc**: Tab navigation + shared counter
- **AnalyticsBloc**: Navigation utilities + debugging

### Debugging Tools

- Router stack logging
- Tabs router stack inspection
- Current route information

## 📁 Project Structure

```
lib/
├── main.dart
├── router/
│   ├── app_router.dart
│   ├── app_router.gr.dart (generated)
│   └── app_router_observer.dart
├── blocs/
│   ├── home/
│   │   ├── home_bloc.dart
│   │   ├── home_event.dart
│   │   └── home_state.dart
│   └── analytics/
│       ├── analytics_bloc.dart
│       ├── analytics_event.dart
│       └── analytics_state.dart
└── screens/
    ├── home_screen.dart
    ├── dashboard_screen.dart
    ├── profile_screen.dart
    ├── settings_screen.dart
    ├── analytics_screen.dart
    ├── charts_screen.dart
    ├── reports_screen.dart
    └── statistics_screen.dart
```

## 📚 Documentation

- **[AUTO_ROUTE_DEMO.md](AUTO_ROUTE_DEMO.md)** - Chi tiết về routing implementation
- **[BLOC_IMPLEMENTATION.md](BLOC_IMPLEMENTATION.md)** - Chi tiết về Bloc pattern
- **[DEMO_FEATURES.md](DEMO_FEATURES.md)** - Tổng hợp features và testing guide

## 📦 Dependencies

```yaml
dependencies:
  auto_route: ^10.1.2
  flutter_bloc: ^9.1.1
  equatable: ^2.0.5

dev_dependencies:
  auto_route_generator: ^10.2.4
  build_runner: ^2.4.13
```

## 🧪 Testing

### Test Shared State

1. Mở app → Dashboard tab
2. Increase counter
3. Chuyển sang Profile → Counter vẫn giữ giá trị
4. Increase ở Profile → Chuyển Settings → Counter đã tăng

### Test Navigation

1. Từ Dashboard → Tap "Open Analytics"
2. Navigate giữa Charts/Reports/Statistics
3. Tap "Log Router Stack" → Check console
4. Tap Home → Về Dashboard

### Test Router Debugging

1. Tap "Log Router Stack" ở bất kỳ screen nào
2. Check console logs cho stack information
3. Verify nested routing structure

## 🛠️ Development

### Watch mode (auto rebuild)

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Clean và rebuild

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

## 💡 Key Concepts

### AutoTabsScaffold

Dùng cho tab-based navigation với state persistence:

```dart
AutoTabsScaffold(
  routes: const [DashboardRoute(), ProfileRoute(), SettingsRoute()],
  bottomNavigationBuilder: (context, tabsRouter) { ... },
)
```

### AutoRouter

Tạo nested route:

```dart
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
)
```

Dùng cho push/pop nested Screen:

```dart
@RoutePage()
class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }
}
```

### Shared State via Bloc

Provide Bloc ở parent route để share state với children:
```dart
@override
Widget wrappedRoute(BuildContext context) {
  return BlocProvider(
    create: (context) => HomeBloc()..add(const HomeEvent.initialize()),
    child: this,
  );
}
```

Sau khi provider HomeBloc cho HomeScreen thì toàn bộ các Route khác nằm trong HomeScreen đều có thể truy cập vào HomeBloc. Từ đó giúp ta có thể tập trung các logic dùng và dữ liệu lư vào 1 bloc tổng thể để giảm thiểu việc phải chuyển data giữa các màn hình và dễ update data khi sử dụng ở nhiều màn hinh khác nhau

## 🎓 Learning Resources

- [Auto Route Documentation](https://pub.dev/packages/auto_route)
- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Auto Route GitHub](https://github.com/Milad-Akarie/auto_route_library)
- [Bloc Core Concepts](https://bloclibrary.dev/bloc-concepts/)

## 📝 Notes

- Project này là demo cho learning purposes
- Shared counter đơn giản để minh họa state sharing
- Router stack logging giúp debug nested routing
- Code sử dụng sealed classes và freezed-style factories

## 🤝 Contributing

This is a demo project. Feel free to use it as reference for your own projects.

## 📄 License

This project is open source and available for educational purposes.
