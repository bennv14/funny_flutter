import 'dart:developer' as dev;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<_HomeInitialize>(_onInitialize);
    on<_HomeChangeTab>(_onChangeTab);
    on<_HomeIncrementCounter>(_onIncrementCounter);
    on<_HomeDecrementCounter>(_onDecrementCounter);
    on<_HomeLogRouterStack>(_onLogRouterStack);
  }

  void _onInitialize(
    _HomeInitialize event,
    Emitter<HomeState> emit,
  ) {
    emit(const HomeState());
  }

  void _onChangeTab(
    _HomeChangeTab event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
  }

  void _onIncrementCounter(
    _HomeIncrementCounter event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _onDecrementCounter(
    _HomeDecrementCounter event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(counter: state.counter - 1));
  }
 

  void _onLogRouterStack(_HomeLogRouterStack event, Emitter<HomeState> emit,) {
    dev.log('xxxx route ${event.context.router.stack}');
    dev.log('xxxx tabs route ${event.context.tabsRouter.stack}');
  }
}
