import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int? saveMenuPreviousPage = 0;
  final controller = PageController();
  final menuController = PageController();

  HomeBloc() : super(InitialState());

  @override
  Future<void> close() async {}

  Future<void> dispose() async {
    super.close();
  }
}
