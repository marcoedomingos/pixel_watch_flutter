import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_watch/features/clock/logic/clock_state.dart';

part 'clock_event.dart';

class ClockBloc extends Bloc<ClockEvent, ClockState> {
  StreamSubscription<int>? _tickerSubscription;

  ClockBloc() : super(ClockState(DateTime.now())) {
    on<StartClock>(_onStartClock);
    on<_Tick>(_onTick);
  }

  void _onStartClock(StartClock event, Emitter<ClockState> emit) {
    _tickerSubscription?.cancel();
    _tickerSubscription = Stream.periodic(const Duration(seconds: 1), (i) => i).listen(
      (i) => add(_Tick(DateTime.now())),
    );
  }

  void _onTick(_Tick event, Emitter<ClockState> emit) {
    emit(ClockState(event.time));
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
