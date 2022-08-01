part of 'heartbeat_bloc.dart';

abstract class HeartbeatEvent{}

class HeartBeatCount extends HeartbeatEvent{}

class IncreaseHeartBeat extends HeartbeatEvent{}

class DecreaseHeartBeat extends HeartbeatEvent{}

class StartHeartBeat extends HeartbeatEvent{}

class HeartBeatSequence extends HeartbeatEvent{}