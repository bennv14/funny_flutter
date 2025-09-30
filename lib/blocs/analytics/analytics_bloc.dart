import 'dart:developer' as dev;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:funny_flutter/router/app_router.gr.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(const AnalyticsState()) {
    on<_AnalyticsInitialize>(_onInitialize);
    on<_AnalyticsChangeTab>(_onChangeTab);
    on<_AnalyticsLogRouterStack>(_onLogRouterStack);
    on<_AnalyticsPopToRoot>(_onPopToRoot);
    on<_AnalyticsBack>(_onBack);
  }

  void _onInitialize(_AnalyticsInitialize event, Emitter<AnalyticsState> emit) {
    print('xxxx initialize analytics');
  }

  void _onChangeTab(_AnalyticsChangeTab event, Emitter<AnalyticsState> emit) {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
  }

  void _onLogRouterStack(
    _AnalyticsLogRouterStack event,
    Emitter<AnalyticsState> emit,
  ) {
    try {
      dev.log('xxxx route ${event.context.router.stack}');
      dev.log('xxxx tabs route ${event.context.tabsRouter.stack}');
      dev.log('xxxx current route ${event.context.router.current}');
    } catch (e) {
      dev.log('xxxx analytic $e ${e.runtimeType}');
    }
  }

  void _onPopToRoot(_AnalyticsPopToRoot event, Emitter<AnalyticsState> emit) {
    event.context.router.popUntilRoot();
    event.context.router.maybePop();
  }

  void _onBack(_AnalyticsBack event, Emitter<AnalyticsState> emit) {
    event.context.router.maybePop();
  }
}
