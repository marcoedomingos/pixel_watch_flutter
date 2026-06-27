part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class InitializeHome extends HomeEvent {}

class ToggleScreen extends HomeEvent {
  final bool enabled;
  final double opacity;

  const ToggleScreen({required this.enabled, required this.opacity});

  @override
  List<Object> get props => [enabled, opacity];
}

class ChangePage extends HomeEvent {
  final int index;

  const ChangePage(this.index);

  @override
  List<Object> get props => [index];
}

class ShowBottomWarning extends HomeEvent {}

class HideBottomWarning extends HomeEvent {}
