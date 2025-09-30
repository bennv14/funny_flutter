part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const factory AnalyticsEvent.initialize() = _AnalyticsInitialize;
  const factory AnalyticsEvent.changeTab(int tabIndex) = _AnalyticsChangeTab;
  const factory AnalyticsEvent.logRouterStack(BuildContext context) = _AnalyticsLogRouterStack;
  const factory AnalyticsEvent.popToRoot(BuildContext context) = _AnalyticsPopToRoot;
  const factory AnalyticsEvent.back(BuildContext context) = _AnalyticsBack;
  
  const AnalyticsEvent();
}

class _AnalyticsInitialize extends AnalyticsEvent {
  const _AnalyticsInitialize();

  @override
  List<Object?> get props => [];
}

class _AnalyticsChangeTab extends AnalyticsEvent {
  final int tabIndex;

  const _AnalyticsChangeTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class _AnalyticsLogRouterStack extends AnalyticsEvent {
  final BuildContext context;

  const _AnalyticsLogRouterStack(this.context);

  @override
  List<Object?> get props => [context];
}

class _AnalyticsPopToRoot extends AnalyticsEvent {
  final BuildContext context;

  const _AnalyticsPopToRoot(this.context);

  @override
  List<Object?> get props => [context];
}

class _AnalyticsBack extends AnalyticsEvent {
  final BuildContext context;

  const _AnalyticsBack(this.context);

  @override
  List<Object?> get props => [context];
}
