# Bloc Implementation Documentation

Tài liệu chi tiết về Bloc state management được sử dụng trong demo Auto Route Nested.

## 📁 Cấu trúc

```
lib/
├── blocs/
│   ├── home/
│   │   ├── home_bloc.dart        # Main bloc file
│   │   ├── home_event.dart       # Events (part of home_bloc.dart)
│   │   └── home_state.dart       # States (part of home_bloc.dart)
│   └── analytics/
│       ├── analytics_bloc.dart   # Main bloc file  
│       ├── analytics_event.dart  # Events (part of analytics_bloc.dart)
│       └── analytics_state.dart  # States (part of analytics_bloc.dart)
└── screens/
    ├── home_screen.dart          # Sử dụng HomeBloc
    ├── dashboard_screen.dart     # Access HomeBloc (shared)
    ├── profile_screen.dart       # Access HomeBloc (shared)
    ├── settings_screen.dart      # Access HomeBloc (shared)
    ├── analytics_screen.dart     # Sử dụng AnalyticsBloc
    ├── charts_screen.dart        # Access AnalyticsBloc (shared)
    ├── reports_screen.dart       # Access AnalyticsBloc (shared)
    └── statistics_screen.dart    # Access AnalyticsBloc (shared)
```

## 🎯 Bloc Pattern Overview

Cả 2 Blocs đều sử dụng **Bloc pattern** (không phải Cubit):
- Event-driven architecture
- Có Events và States riêng biệt  
- Clear separation of concerns
- Testable và maintainable
- Phù hợp cho cả simple và complex state management

## 📦 Chi tiết từng Bloc

### 1. HomeBloc

**Mục đích**: Quản lý tab navigation và shared counter state cho Home group

#### Events

```dart
sealed class HomeEvent extends Equatable {
  const HomeEvent();
  
  const factory HomeEvent.initialize() = _HomeInitialize;
  const factory HomeEvent.changeTab(int tabIndex) = _HomeChangeTab;
  const factory HomeEvent.incrementCounter() = _HomeIncrementCounter;
  const factory HomeEvent.decrementCounter() = _HomeDecrementCounter;
  const factory HomeEvent.logRouterStack(BuildContext context) = _HomeLogRouterStack;
}
```

**Event Handlers**:
- `_HomeInitialize`: Reset về state ban đầu (tab 0, counter 0)
- `_HomeChangeTab`: Update currentTabIndex khi chuyển tab
- `_HomeIncrementCounter`: Tăng counter thêm 1
- `_HomeDecrementCounter`: Giảm counter đi 1
- `_HomeLogRouterStack`: Log router stack và tabs router stack ra console

#### State

```dart
class HomeState extends Equatable {
  final int currentTabIndex;  // 0=Dashboard, 1=Profile, 2=Settings
  final int counter;           // Shared counter value
  
  const HomeState({
    this.currentTabIndex = 0,
    this.counter = 0,
  });
  
  HomeState copyWith({
    int? currentTabIndex,
    int? counter,
  }) { ... }
  
  @override
  List<Object?> get props => [currentTabIndex, counter];
}
```

#### Features

1. **Tab Navigation State**
   - Track tab hiện tại (Dashboard/Profile/Settings)
   - Update khi user chuyển tab
   - Hiển thị trong AppBar ("Tab: X")

2. **Shared Counter**
   - Counter được share giữa 3 nested screens
   - Dashboard, Profile, Settings đều có thể increment/decrement
   - State được persist khi chuyển tab
   - Demo về shared state trong nested routing

3. **Router Debugging**
   - Log full router stack
   - Log tabs router stack
   - Giúp debug nested routing issues

#### Sử dụng

**Khởi tạo (HomeScreen)**:
```dart
@override
Widget wrappedRoute(BuildContext context) {
  return BlocProvider(
    create: (context) => HomeBloc()..add(const HomeEvent.initialize()),
    child: this,
  );
}
```

**Đọc state và dispatch events (Dashboard/Profile/Settings)**:
```dart
BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return Column(
      children: [
        Text('Counter: ${state.counter}'),
        ElevatedButton(
          onPressed: () {
            context.read<HomeBloc>().add(
              const HomeEvent.incrementCounter(),
            );
          },
          child: Text('Increase'),
        ),
      ],
    );
  },
)
```

---

### 2. AnalyticsBloc

**Mục đích**: Quản lý navigation và routing utilities cho Analytics group

#### Events

```dart
sealed class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();
  
  const factory AnalyticsEvent.initialize() = _AnalyticsInitialize;
  const factory AnalyticsEvent.changeTab(int tabIndex) = _AnalyticsChangeTab;
  const factory AnalyticsEvent.logRouterStack(BuildContext context) = _AnalyticsLogRouterStack;
  const factory AnalyticsEvent.popToRoot(BuildContext context) = _AnalyticsPopToRoot;
  const factory AnalyticsEvent.back(BuildContext context) = _AnalyticsBack;
}
```

**Event Handlers**:
- `_AnalyticsInitialize`: Khởi tạo analytics (print log)
- `_AnalyticsChangeTab`: Update tab index (nếu cần)
- `_AnalyticsLogRouterStack`: Log full stack, tabs stack, current route
- `_AnalyticsPopToRoot`: Pop về root và close analytics group
- `_AnalyticsBack`: Navigate back một bước

#### State

```dart
class AnalyticsState extends Equatable {
  final int currentTabIndex;  // Tab index (không dùng nhiều vì không có tabs UI)
  
  const AnalyticsState({
    this.currentTabIndex = 0,
  });
  
  AnalyticsState copyWith({
    int? currentTabIndex,
  }) { ... }
  
  @override
  List<Object?> get props => [currentTabIndex];
}
```

#### Features

1. **Navigation Utilities**
   - PopToRoot: Close analytics và về Home
   - Back: Navigate back một bước
   - Handle navigation logic trong Bloc thay vì UI

2. **Router Stack Debugging**
   - Log router stack (full navigation history)
   - Log tabs router stack (nếu có)
   - Log current route
   - Catch và log errors

3. **Initial Route Handling**
   - Analytics có thể mở với specific initial route
   - ví dụ: `AnalyticsRoute(initialRouteName: ReportsRoute.name)`
   - Được handle trong `AnalyticsScreen.initState()`

#### Sử dụng

**Khởi tạo (AnalyticsScreen)**:
```dart
@override
Widget wrappedRoute(BuildContext context) {
  return BlocProvider(
    create: (context) =>
        AnalyticsBloc()..add(const AnalyticsEvent.initialize()),
    lazy: false,
    child: this,
  );
}
```

**Dispatch navigation events (Charts/Reports/Statistics)**:
```dart
// Pop về root
ElevatedButton(
  onPressed: () {
    context.read<AnalyticsBloc>().add(
      AnalyticsEvent.popToRoot(context),
    );
  },
  child: Text('Home'),
)

// Navigate back
ElevatedButton(
  onPressed: () {
    context.read<AnalyticsBloc>().add(
      AnalyticsEvent.back(context),
    );
  },
  child: Text('Back'),
)

// Log stack
ElevatedButton(
  onPressed: () {
    context.read<AnalyticsBloc>().add(
      AnalyticsEvent.logRouterStack(context),
    );
  },
  child: Text('Log Router Stack'),
)
```

---

## 🔄 Bloc Pattern trong Project

### Event-Driven Architecture

Tất cả state changes đều driven bởi events:
```dart
// Bad - Directly modifying state
state.counter++;

// Good - Dispatch event
context.read<HomeBloc>().add(const HomeEvent.incrementCounter());
```

### Separation of Concerns

- **Blocs**: Business logic và state management
- **Screens**: UI và user interactions
- **Events**: User actions và system events
- **States**: Immutable data snapshots

### State Sharing via BlocProvider

**HomeBloc** được provide ở `HomeScreen` level:
- Dashboard, Profile, Settings đều access cùng một instance
- Counter state được share giữa 3 screens
- Implement via `AutoRouteWrapper.wrappedRoute()`

**AnalyticsBloc** được provide ở `AnalyticsScreen` level:
- Charts, Reports, Statistics đều access cùng một instance
- Navigation utilities available cho tất cả nested screens

---

## 📝 Best Practices

### 1. File Organization với `part of`

Tách Events và States thành files riêng:

**Main bloc file**:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> { ... }
```

**Event file**:
```dart
part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable { ... }
```

**State file**:
```dart
part of 'home_bloc.dart';

class HomeState extends Equatable { ... }
```

### 2. Sealed Classes cho Events

Sử dụng `sealed class` với factory constructors:
```dart
sealed class HomeEvent extends Equatable {
  const HomeEvent();
  
  const factory HomeEvent.initialize() = _HomeInitialize;
  const factory HomeEvent.changeTab(int tabIndex) = _HomeChangeTab;
}

class _HomeInitialize extends HomeEvent { ... }
class _HomeChangeTab extends HomeEvent { ... }
```

**Benefits**:
- Type safety và exhaustive checking
- Clean API cho consumers
- IDE autocomplete support

### 3. State Immutability

Tất cả states extend `Equatable`:
```dart
class HomeState extends Equatable {
  final int counter;
  
  const HomeState({this.counter = 0});
  
  HomeState copyWith({int? counter}) {
    return HomeState(counter: counter ?? this.counter);
  }
  
  @override
  List<Object?> get props => [counter];
}
```

**Benefits**:
- Accurate state comparisons
- Prevent unnecessary rebuilds
- Easier debugging

### 4. BlocProvider Placement

**Route-level Provider** (via AutoRouteWrapper):
```dart
@RoutePage()
class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeEvent.initialize()),
      child: this,
    );
  }
}
```

**Benefits**:
- Share Bloc với tất cả nested screens
- Automatic dispose khi route bị pop
- Clean dependency injection

### 5. Event Naming

Events nên rõ ràng và action-oriented:
```dart
// Good
const HomeEvent.incrementCounter()
const HomeEvent.changeTab(index)
const AnalyticsEvent.popToRoot(context)

// Bad
const HomeEvent.update()
const HomeEvent.tap(index)
const AnalyticsEvent.navigate(context)
```

### 6. Context Passing

Pass BuildContext qua events khi cần cho navigation:
```dart
const factory AnalyticsEvent.popToRoot(BuildContext context) = _AnalyticsPopToRoot;

void _onPopToRoot(_AnalyticsPopToRoot event, Emitter<AnalyticsState> emit) {
  event.context.router.popUntilRoot();
  event.context.router.maybePop();
}
```

**Alternative**: Inject router vào Bloc (cleaner nhưng phức tạp hơn)

---

## 🧪 Testing

### Test Blocs

```dart
blocTest<HomeBloc, HomeState>(
  'incrementCounter increases counter by 1',
  build: () => HomeBloc(),
  act: (bloc) => bloc.add(const HomeEvent.incrementCounter()),
  expect: () => [const HomeState(counter: 1)],
);

blocTest<HomeBloc, HomeState>(
  'changeTab updates currentTabIndex',
  build: () => HomeBloc(),
  act: (bloc) => bloc.add(const HomeEvent.changeTab(2)),
  expect: () => [const HomeState(currentTabIndex: 2)],
);
```

### Test với Multiple Events

```dart
blocTest<HomeBloc, HomeState>(
  'multiple increments',
  build: () => HomeBloc(),
  act: (bloc) {
    bloc.add(const HomeEvent.incrementCounter());
    bloc.add(const HomeEvent.incrementCounter());
    bloc.add(const HomeEvent.incrementCounter());
  },
  expect: () => [
    const HomeState(counter: 1),
    const HomeState(counter: 2),
    const HomeState(counter: 3),
  ],
);
```

---

## 📚 Tài liệu tham khảo

- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Bloc Core Concepts](https://bloclibrary.dev/bloc-concepts/)
- [Equatable Package](https://pub.dev/packages/equatable)
- [bloc_test Package](https://pub.dev/packages/bloc_test)
- [Bloc Best Practices](https://bloclibrary.dev/architecture/)