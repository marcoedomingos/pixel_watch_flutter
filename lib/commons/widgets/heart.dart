import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/core/presentation/bloc/heartbeat/heartbeat_bloc.dart';

class HeartWidget extends StatefulWidget {
  final double size;

  const HeartWidget({Key? key, this.size = 10,}) : super(key: key);

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget> {
  final bloc = injectionInstance<HeartbeatBloc>();

  @override
  void initState() {
    super.initState();
    setState(() {
      bloc.size = widget.size;
      bloc.runDelayed = true;
      bloc.add(StartHeartBeat());
    });
  }

  @override
  void dispose() {
    super.dispose();
    bloc.runDelayed = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<HeartbeatBloc, HeartbeatState>(
          builder: (context, state) => SizedBox(
                width: widget.size * 5,
                height: widget.size * 5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Card(
                      elevation: 0,
                      color: primaryBlack(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -3,
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)),
                        color: primaryBlack(),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: AnimatedContainer(
                            width: bloc.size * 1.3,
                            height: bloc.size * 1.3,
                            duration: Duration(microseconds: 1),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Icon(
                                Icons.favorite,
                                color: Color(0xfffffdd0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 0,
                          child: HeartBPMDialog(
                            context: context,
                            onRawData: (value) {},
                            onBPM: (value) {
                              if (bloc.getHeartBpm == true) {
                                bloc.bpm = value;
                                bloc.add(HeartBeatCount());
                              }
                            },
                          ),
                        ),
                        Text(
                          state.bpm!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: widget.size * 1.2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
    );
  }
}
