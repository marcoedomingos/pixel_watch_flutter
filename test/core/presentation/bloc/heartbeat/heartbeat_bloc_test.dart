import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/core/presentation/bloc/heartbeat/heartbeat_bloc.dart';

void main() {
  late HeartbeatBloc heartbeatBloc;

  setUp(() {
    heartbeatBloc = HeartbeatBloc();
  });

  group("Should test all possible events in the HeartBeatBloc", () {
    blocTest(
        "should call the HeartBeatCount event and not emit the state",
        build: () => heartbeatBloc,
        act: (bloc) => heartbeatBloc.add(HeartBeatCount()),
        expect: ()=> []
    );

    blocTest<HeartbeatBloc, HeartbeatState>(
      "should call the StartHeartBeat event and emit the state",
      build: () => heartbeatBloc,
      act: (bloc) => bloc.add(StartHeartBeat()),
      expect: ()=> [isInstanceOf<HeartbeatState>()]
    );

    blocTest<HeartbeatBloc, HeartbeatState>(
        "should call the IncreaseHeartBeat event and and not emit the state",
        build: () => heartbeatBloc,
        act: (bloc) => bloc.add(IncreaseHeartBeat()),
        expect: ()=> []
    );

    blocTest<HeartbeatBloc, HeartbeatState>(
        "should call the DecreaseHeartBeat event and emit the state",
        build: () => heartbeatBloc,
        act: (bloc) => bloc.add(DecreaseHeartBeat()),
        expect: ()=> []
    );

    blocTest<HeartbeatBloc, HeartbeatState>(
        "should call the HeartBeatSequence event and emit the state",
        build: () => heartbeatBloc,
        act: (bloc) => bloc.add(HeartBeatSequence()),
        expect: ()=> [isInstanceOf<HeartbeatState>()]
    );
  });

  tearDown(() => heartbeatBloc.dispose());
}
