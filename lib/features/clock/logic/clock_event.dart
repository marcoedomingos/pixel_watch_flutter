part of 'clock_bloc.dart';

abstract class ClockEvent extends Equatable {
  const ClockEvent();

  @override
  List<Object?> get props => [];
}

class StartClock extends ClockEvent {}

class _Tick extends ClockEvent {
  final DateTime time;
  const _Tick(this.time);

  @override
  List<Object?> get props => [time];
}
