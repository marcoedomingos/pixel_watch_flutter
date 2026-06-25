import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/features/heart_rate/logic/heartbeat_bloc.dart';

class HeartWidget extends StatefulWidget {
  final double size;

  const HeartWidget({Key? key, this.size = 10,}) : super(key: key);

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<HeartbeatBloc>();
    bloc.add(SetBaseSize(widget.size));
    bloc.add(StartHeartBeatAnimation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeartbeatBloc, HeartbeatState>(
      builder: (context, state) {
        return SizedBox(
          width: widget.size * 5,
          height: widget.size * 5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildProgressIndicator(),
              _buildHeartIcon(state),
              _buildBpmDisplay(state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Card(
      elevation: 0,
      color: AppColors.primaryBlack,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
      child: const Padding(
        padding: EdgeInsets.all(2.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white10,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.transparent),
        ),
      ),
    );
  }

  Widget _buildHeartIcon(HeartbeatState state) {
    return Positioned(
      top: -3,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        color: AppColors.primaryBlack,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: AnimatedContainer(
            width: state.heartSize * 1.3,
            height: state.heartSize * 1.3,
            duration: const Duration(milliseconds: 100),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                Icons.favorite,
                color: Color(0xfffffdd0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBpmDisplay(HeartbeatState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0,
          child: HeartBPMDialog(
            context: context,
            onRawData: (value) {},
            onBPM: (value) {
              context.read<HeartbeatBloc>().add(UpdateBPM(value));
            },
          ),
        ),
        Text(
          state.displayBpm,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: widget.size * 1.2,
          ),
        ),
      ],
    );
  }
}
