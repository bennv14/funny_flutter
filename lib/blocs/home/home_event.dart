part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const factory HomeEvent.initialize() = _HomeInitialize;
  const factory HomeEvent.changeTab(int tabIndex) = _HomeChangeTab;
  const factory HomeEvent.incrementCounter() = _HomeIncrementCounter;
  const factory HomeEvent.decrementCounter() = _HomeDecrementCounter;
  const factory HomeEvent.logRouterStack(BuildContext context) = _HomeLogRouterStack;
  
  const HomeEvent();
}

class _HomeInitialize extends HomeEvent {
  const _HomeInitialize();

  @override
  List<Object?> get props => [];
}

class _HomeChangeTab extends HomeEvent {
  final int tabIndex;

  const _HomeChangeTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class _HomeIncrementCounter extends HomeEvent {
  const _HomeIncrementCounter();

  @override
  List<Object?> get props => [];
}

class _HomeDecrementCounter extends HomeEvent {
  const _HomeDecrementCounter();

  @override
  List<Object?> get props => [];
}

class _HomeLogRouterStack extends HomeEvent {
  final BuildContext context;

  const _HomeLogRouterStack(this.context);

  @override
  List<Object?> get props => [context];
}
