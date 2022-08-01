import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'heartbeat_event.dart';

class HeartbeatState {
  final String? bpm;
  final double? size;

  HeartbeatState({
    @required this.bpm,
    @required this.size,
  });
}

class HeartbeatBloc extends Bloc<HeartbeatEvent, HeartbeatState> {
  bool getHeartBpm = true;
  bool runDelayed = true;
  double size = 50;
  int bpm = 0;
  int heartBpm = 0;

  HeartbeatBloc()
      : super(HeartbeatState(
          bpm: "--",
          size: 50,
        )) {
    // Method that get and Count the Heart Bpm
    on<HeartBeatCount>((event, emit) async {
      if (getHeartBpm == true) {
        getHeartBpm = false;
        if (heartBpm < bpm) {
          add(IncreaseHeartBeat());
        } else {
          add(DecreaseHeartBeat());
        }
        if(runDelayed == true){
          Future.delayed(Duration(seconds: 15), () {
            getHeartBpm = true;
          });
        }
      }
    });

    // Method that increase the Heart Bpm
    on<IncreaseHeartBeat>((event, emit) async {
      if (heartBpm < bpm) {
        if(runDelayed == true){
          Future.delayed(Duration(milliseconds: 1), () {
            heartBpm += 1;
            add(IncreaseHeartBeat());
          });
        }
        emit(HeartbeatState(
          bpm: heartBpm.toString(),
          size: size,
        ));
      }
    });

    // Method that decrease the Heart Bpm
    on<DecreaseHeartBeat>((event, emit) async {
      if (heartBpm > bpm) {
        if(runDelayed == true){
          Future.delayed(Duration(milliseconds: 1), () {
            heartBpm -= 1;
            add(DecreaseHeartBeat());
          });
        }
        emit(HeartbeatState(
          bpm: heartBpm.toString(),
          size: size,
        ));
      }
    });

    // Method that start the heart beat effect
    on<StartHeartBeat>((event, emit) async {
      add(HeartBeatSequence());
      if(runDelayed == true){
        Future.delayed(Duration(milliseconds: 400), () {
          add(HeartBeatSequence());
        });
        Future.delayed(Duration(milliseconds: 3000), () {
          add(StartHeartBeat());
        });
      }
    });

    // Method that make the heart increase effect
    on<HeartBeatSequence>((event, emit) async {
      size = size / 1.2;
      emit(HeartbeatState(
        bpm: heartBpm.toString(),
        size: size,
      ));
      if(runDelayed == true){
        await Future.delayed(Duration(milliseconds: 100), () {
          size = size * 1.2;
          emit(HeartbeatState(
            bpm: heartBpm.toString(),
            size: size,
          ));
        });
      }
    });
  }

  @override
  Future<void> close() async {

  }

  Future<void> dispose() async {
    super.close();
  }
}
