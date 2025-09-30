part of 'analytics_bloc.dart';

class AnalyticsState extends Equatable {
  final int currentTabIndex;

  const AnalyticsState({
    this.currentTabIndex = 0,
  });

  AnalyticsState copyWith({
    int? currentTabIndex,
  }) {
    return AnalyticsState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  List<Object?> get props => [currentTabIndex];
}
