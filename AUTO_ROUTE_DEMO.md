# Auto Route Nested Demo với Bloc

Demo này minh họa cách sử dụng **auto_route** với **nested routes**, **multiple route groups** và **Bloc state management** trong Flutter.

## 📱 Tổng quan

Ứng dụng demo bao gồm:
- **2 route groups**: Home và Analytics
- **Nested routing** với AutoTabsScaffold và AutoRouter
- **Shared state** giữa các nested screens (shared counter)
- **Bloc pattern** cho state management
- **Navigation utilities** và router stack debugging

## 📁 Cấu trúc

```
lib/
├── main.dart                      # Entry point của app
├── router/
│   ├── app_router.dart           # Cấu hình routing
│   ├── app_router.gr.dart        # Generated router code (auto_route_generator)
│   └── app_router_observer.dart  # Router observer cho debugging
├── blocs/                         # Bloc state management
│   ├── home/
│   │   ├── home_bloc.dart        # Main bloc file
│   │   ├── home_event.dart       # Events (part of)
│   │   └── home_state.dart       # States (part of)
│   └── analytics/
│       ├── analytics_bloc.dart   # Main bloc file
│       ├── analytics_event.dart  # Events (part of)
│       └── analytics_state.dart  # States (part of)
└── screens/
    ├── home_screen.dart          # Home container với AutoTabsScaffold
    ├── dashboard_screen.dart     # Nested screen 1 (dưới Home)
    ├── profile_screen.dart       # Nested screen 2 (dưới Home)
    ├── settings_screen.dart      # Nested screen 3 (dưới Home)
    ├── analytics_screen.dart     # Analytics container với AutoRouter
    ├── charts_screen.dart        # Nested screen 1 (dưới Analytics)
    ├── reports_screen.dart       # Nested screen 2 (dưới Analytics)
    └── statistics_screen.dart    # Nested screen 3 (dưới Analytics)
```

## 🛣️ Router Configuration

### Route Structure

```dart
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Home route group với AutoTabsScaffold
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          children: [
            AutoRoute(page: DashboardRoute.page, initial: true),
            AutoRoute(page: ProfileRoute.page),
            AutoRoute(page: SettingsRoute.page),
          ],
        ),
        // Analytics route group với nested navigation
        AutoRoute(
          page: AnalyticsRoute.page,
          children: [
            AutoRoute(page: ChartsRoute.page, initial: true),
            AutoRoute(page: ReportsRoute.page),
            AutoRoute(page: StatisticsRoute.page),
          ],
        ),
      ];
}
```

### Route Groups

#### 1. Home Group (AutoTabsScaffold)
- **Container**: `HomeScreen` với `AutoTabsScaffold`
- **Navigation**: Bottom navigation bar với 3 tabs
- **Children**: Dashboard, Profile, Settings
- **Features**: Shared counter state giữa 3 tabs

#### 2. Analytics Group (AutoRouter)
- **Container**: `AnalyticsScreen` với `AutoRouter`
- **Navigation**: Push/pop navigation giữa các screens
- **Children**: Charts, Reports, Statistics
- **Features**: Navigation buttons và router stack debugging

## 🎛️ Bloc State Management

### 1. HomeBloc

**Mục đích**: Quản lý tab navigation và shared counter state

**Events**:
- `initialize`: Khởi tạo home với tab 0 và counter 0
- `changeTab(int tabIndex)`: Thay đổi tab hiện tại
- `incrementCounter`: Tăng shared counter
- `decrementCounter`: Giảm shared counter
- `logRouterStack(BuildContext)`: Log router stack ra console

**State**:
```dart
class HomeState {
  final int currentTabIndex;  // 0, 1, 2 (Dashboard, Profile, Settings)
  final int counter;           // Shared counter value
}
```

**Sử dụng**:
- Dashboard, Profile, Settings screens đều có thể đọc và thay đổi counter
- Counter được share giữa 3 tabs, khi thay đổi ở tab nào thì các tab khác cũng thấy

### 2. AnalyticsBloc

**Mục đích**: Quản lý navigation trong Analytics group và utilities

**Events**:
- `initialize`: Khởi tạo analytics
- `changeTab(int)`: Thay đổi tab (nếu cần)
- `logRouterStack(BuildContext)`: Log router stack và tabs router stack
- `popToRoot(BuildContext)`: Pop về root và close analytics
- `back(BuildContext)`: Navigate back một bước

**State**:
```dart
class AnalyticsState {
  final int currentTabIndex;  // Tab index (không sử dụng nhiều)
}
```

**Sử dụng**:
- Charts, Reports, Statistics screens sử dụng để navigate và debug
- Có Home button để pop về root
- Có Back button để navigate back

## 🎨 Features Demo

### 1. Nested Routing với AutoTabsScaffold (Home Group)

**HomeScreen** sử dụng `AutoTabsScaffold`:
- Bottom navigation bar với 3 tabs
- Mỗi tab giữ state riêng khi chuyển đổi
- AppBar hiển thị tab hiện tại
- Share HomeBloc provider cho tất cả children

### 2. Shared State (Counter)

**Dashboard, Profile, Settings screens**:
- Tất cả 3 screens đều hiển thị cùng một counter
- Mỗi screen có 2 buttons: Increase và Decrease
- Counter được quản lý bởi HomeBloc và share giữa các tabs
- Màu card khác nhau: Dashboard (blue), Profile (purple), Settings (orange)

### 3. Nested Navigation (Analytics Group)

**AnalyticsScreen** với nested routes:
- Push từ Home group sang Analytics group
- Charts/Reports/Statistics có thể navigate qua lại
- Home button để pop về root (close analytics và về Home)
- Back button để pop một bước
- Log Router Stack button để debug routing

### 4. Router Debugging

**Log Router Stack feature**:
- Hiển thị full router stack
- Hiển thị tabs router stack (nếu có)
- Hiển thị current route
- Giúp debug nested routing

## 🚀 Chạy Demo

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

## 🧪 Cách test

### Test Home Group (AutoTabsScaffold)

1. Mở app → Xem Dashboard tab (mặc định)
2. Tap Increase/Decrease → Counter thay đổi
3. Chuyển sang Profile tab → Counter vẫn giữ nguyên giá trị
4. Increase counter ở Profile → Chuyển sang Settings → Counter đã tăng
5. Xem AppBar → "Tab: X" thay đổi theo tab hiện tại
6. Tap "Log Router Stack" → Xem console logs

### Test Navigation giữa Route Groups

1. Ở Dashboard tab → Tap "Open Analytics"
2. Mở Analytics với Reports screen (initialRouteName)
3. Tap buttons để navigate giữa Charts/Reports/Statistics
4. Tap Home button → Pop về Home group
5. Test từ Profile → Tap "Open Charts" → Mở ReportsRoute directly

### Test Analytics Navigation

1. Từ Charts → Tap "Reports" hoặc "Statistics"
2. Từ Reports → Navigate sang Charts hoặc Statistics
3. Từ Statistics → Navigate sang các screens khác
4. Tap "Log Router Stack" ở bất kỳ screen nào → Xem nested stack
5. Tap Back button → Pop một bước
6. Tap Home button → Pop về root và close analytics

## 📝 Các lệnh hữu ích

### Build runner watch mode

Tự động rebuild khi thay đổi router config:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Clean và rebuild

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

## 🔧 Mở rộng

### Thêm nested screen mới trong Home group

1. Tạo screen mới với `@RoutePage()` annotation
2. Thêm route vào `children` của `HomeRoute` trong `app_router.dart`
3. Thêm route vào danh sách `routes` trong `HomeScreen.AutoTabsScaffold`
4. Thêm `NavigationDestination` vào bottom navigation bar
5. Chạy `dart run build_runner build`
6. Screen mới có thể access `HomeBloc` để đọc/thay đổi shared counter

### Thêm nested screen mới trong Analytics group

1. Tạo screen mới với `@RoutePage()` annotation
2. Thêm route vào `children` của `AnalyticsRoute` trong `app_router.dart`
3. Thêm navigation buttons trong các screens khác để navigate tới
4. Chạy `dart run build_runner build`
5. Screen mới có thể access `AnalyticsBloc` cho navigation utilities

### Thêm route group mới (ví dụ: Settings Group)

1. Tạo container screen (ví dụ: `SettingsGroupScreen`)
2. Tạo các nested screens
3. Thêm `AutoRoute` mới với `children` vào `app_router.dart`
4. Tạo Bloc mới cho group (nếu cần)
5. Chạy build runner
6. Add navigation từ các screens khác

## 📚 Tài liệu tham khảo

- [Auto Route Documentation](https://pub.dev/packages/auto_route)
- [Auto Route GitHub](https://github.com/Milad-Akarie/auto_route_library)
- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Equatable Package](https://pub.dev/packages/equatable)
- [AutoTabsScaffold Documentation](https://autoroute.vercel.app/nested-routes)

## 💡 Best Practices

1. **AutoRouteWrapper**: Dùng để provide Bloc cho cả route group
2. **Router Observer**: Dùng `AppRouterObserver` để track navigation
3. **Debugging**: Sử dụng router stack logging để debug nested routing
4. **State Sharing**: Share state qua Bloc provider ở parent route
5. **Navigation**: Dùng `context.router.push()` thay vì `Navigator.push()`