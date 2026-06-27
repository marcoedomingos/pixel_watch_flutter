part of 'heartbeat_bloc.dart';

abstract class HeartbeatEvent extends Equatable {
  const HeartbeatEvent();

  @override
  List<Object?> get props => [];
}

class UpdateBPM extends HeartbeatEvent {
  final int bpm;
  const UpdateBPM(this.bpm);

  @override
  List<Object?> get props => [bpm];
}

class SetBaseSize extends HeartbeatEvent {
  final double size;
  const SetBaseSize(this.size);

  @override
  List<Object?> get props => [size];
}

class StartHeartBeatAnimation extends HeartbeatEvent {}

class PulseHeartBeat extends HeartbeatEvent {}

class AnimateHeartBeatStep extends HeartbeatEvent {}
