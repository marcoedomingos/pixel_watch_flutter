import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/size/size.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/core/presentation/bloc/heartbeat/heartbeat_bloc.dart';

class HeartRatePage extends StatefulWidget {
  const HeartRatePage({Key? key}) : super(key: key);

  @override
  State<HeartRatePage> createState() => _HeartRatePageState();
}

class _HeartRatePageState extends State<HeartRatePage> {
  final bloc = injectionInstance<HeartbeatBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack(),
      body: GestureDetector(
        onPanEnd: (details) {
          Navigator.of(context).pop();
        },
        child: Container(
          width: width(context) * .72,
          height: width(context) * .72,
          color: primaryBlack(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Heart Rate",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocProvider.value(
                    value: bloc,
                    child: BlocBuilder<HeartbeatBloc, HeartbeatState>(
                        builder: (context, state) => Text(
                              state.bpm!.toString(),
                              style: TextStyle(
                                fontSize: 270 * 0.4,
                                color: Colors.white,
                              ),
                            )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "BPM",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.blue,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
