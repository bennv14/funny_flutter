part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int currentTabIndex;
  final int counter;

  const HomeState({
    this.currentTabIndex = 0,
    this.counter = 0,
  });

  HomeState copyWith({
    int? currentTabIndex,
    int? counter,
  }) {
    return HomeState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [currentTabIndex, counter];
}
