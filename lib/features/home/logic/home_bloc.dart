import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final controller = PageController();
  final menuController = PageController();
  Timer? _initTimer;
  Timer? _warningTimer;

  HomeBloc() : super(const HomeState()) {
    on<InitializeHome>(_onInitializeHome);
    on<ToggleScreen>(_onToggleScreen);
    on<ChangePage>(_onChangePage);
    on<ShowBottomWarning>(_onShowBottomWarning);
    on<HideBottomWarning>(_onHideBottomWarning);
  }

  FutureOr<void> _onInitializeHome(InitializeHome event, Emitter<HomeState> emit) {
    _initTimer?.cancel();
    _initTimer = Timer(const Duration(seconds: 6), () {
      add(const ChangePage(1));
    });
  }

  FutureOr<void> _onToggleScreen(ToggleScreen event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      showScreens: event.enabled,
      contentOpacity: event.opacity,
    ));
  }

  FutureOr<void> _onChangePage(ChangePage event, Emitter<HomeState> emit) {
    if (controller.hasClients) {
      controller.jumpToPage(event.index);
      emit(state.copyWith(currentPageIndex: event.index));
    }
  }

  FutureOr<void> _onShowBottomWarning(ShowBottomWarning event, Emitter<HomeState> emit) {
    if (!state.bottomIsShowing) {
      emit(state.copyWith(bottomIsShowing: true));
      
      _warningTimer?.cancel();
      _warningTimer = Timer(const Duration(seconds: 5), () {
        add(HideBottomWarning());
      });
    }
  }

  FutureOr<void> _onHideBottomWarning(HideBottomWarning event, Emitter<HomeState> emit) {
    emit(state.copyWith(bottomIsShowing: false));
  }

  @override
  Future<void> close() {
    _initTimer?.cancel();
    _warningTimer?.cancel();
    controller.dispose();
    menuController.dispose();
    return super.close();
  }
}
