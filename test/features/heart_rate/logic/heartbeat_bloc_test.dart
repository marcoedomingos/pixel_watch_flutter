import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_watch/features/heart_rate/logic/heartbeat_bloc.dart';

void main() {
  late HeartbeatBloc heartbeatBloc;

  setUp(() {
    heartbeatBloc = HeartbeatBloc();
  });

  group("Should test all possible events in the HeartBeatBloc", () {
    blocTest<HeartbeatBloc, HeartbeatState>(
      "should call the UpdateBPM event and change targetBpm",
      build: () => heartbeatBloc,
      act: (bloc) => bloc.add(const UpdateBPM(75)),
      expect: () => [
        const HeartbeatState(targetBpm: 75, isMeasuring: true),
      ],
    );

    blocTest<HeartbeatBloc, HeartbeatState>(
      "should call the SetBaseSize event and change sizes",
      build: () => heartbeatBloc,
      act: (bloc) => bloc.add(const SetBaseSize(20.0)),
      expect: () => [
        const HeartbeatState(baseSize: 20.0, heartSize: 20.0),
      ],
    );
  });

  tearDown(() => heartbeatBloc.close());
}
