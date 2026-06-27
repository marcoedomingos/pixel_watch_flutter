import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'heartbeat_event.dart';

class HeartbeatState extends Equatable {
  final int currentBpm;
  final int targetBpm;
  final double heartSize;
  final double baseSize;
  final bool isMeasuring;

  const HeartbeatState({
    this.currentBpm = 0,
    this.targetBpm = 0,
    this.heartSize = 10.0,
    this.baseSize = 10.0,
    this.isMeasuring = false,
  });

  HeartbeatState copyWith({
    int? currentBpm,
    int? targetBpm,
    double? heartSize,
    double? baseSize,
    bool? isMeasuring,
  }) {
    return HeartbeatState(
      currentBpm: currentBpm ?? this.currentBpm,
      targetBpm: targetBpm ?? this.targetBpm,
      heartSize: heartSize ?? this.heartSize,
      baseSize: baseSize ?? this.baseSize,
      isMeasuring: isMeasuring ?? this.isMeasuring,
    );
  }

  @override
  List<Object?> get props => [currentBpm, targetBpm, heartSize, baseSize, isMeasuring];

  String get displayBpm => currentBpm == 0 ? "--" : currentBpm.toString();
}

class HeartbeatBloc extends Bloc<HeartbeatEvent, HeartbeatState> {
  Timer? _bpmTimer;
  Timer? _pulseTimer;

  HeartbeatBloc() : super(const HeartbeatState()) {
    on<UpdateBPM>(_onUpdateBPM);
    on<SetBaseSize>(_onSetBaseSize);
    on<StartHeartBeatAnimation>(_onStartHeartBeatAnimation);
    on<PulseHeartBeat>(_onPulseHeartBeat);
    on<AnimateHeartBeatStep>(_onAnimateHeartBeatStep);
  }

  void _onSetBaseSize(SetBaseSize event, Emitter<HeartbeatState> emit) {
    emit(state.copyWith(baseSize: event.size, heartSize: event.size));
  }

  void _onUpdateBPM(UpdateBPM event, Emitter<HeartbeatState> emit) {
    emit(state.copyWith(targetBpm: event.bpm, isMeasuring: true));
    
    _bpmTimer?.cancel();
    _bpmTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!isClosed) add(AnimateHeartBeatStep());
    });
  }

  void _onStartHeartBeatAnimation(StartHeartBeatAnimation event, Emitter<HeartbeatState> emit) {
    _pulseTimer?.cancel();
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!isClosed) add(PulseHeartBeat());
    });
  }

  Future<void> _onPulseHeartBeat(PulseHeartBeat event, Emitter<HeartbeatState> emit) async {
    emit(state.copyWith(heartSize: state.baseSize / 1.2));
    await Future.delayed(const Duration(milliseconds: 100));
    if (!isClosed) {
      emit(state.copyWith(heartSize: state.baseSize));
    }
  }

  void _onAnimateHeartBeatStep(AnimateHeartBeatStep event, Emitter<HeartbeatState> emit) {
    if (state.currentBpm < state.targetBpm) {
      emit(state.copyWith(currentBpm: state.currentBpm + 1));
    } else if (state.currentBpm > state.targetBpm) {
      emit(state.copyWith(currentBpm: state.currentBpm - 1));
    } else {
      _bpmTimer?.cancel();
    }
  }

  @override
  Future<void> close() {
    _bpmTimer?.cancel();
    _pulseTimer?.cancel();
    return super.close();
  }
}
