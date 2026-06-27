import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/features/home/logic/home_bloc.dart';
import 'package:smart_watch/features/home/ui/widgets/watch_frame.dart';
import 'package:smart_watch/features/home/ui/widgets/watch_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.embedded = false}) : super(key: key);

  final bool embedded;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc;
  final String _languageCode = 'pt_BR';

  @override
  void initState() {
    super.initState();
    _homeBloc = injectionInstance<HomeBloc>();
    initializeDateFormatting(_languageCode);
    
    if (!widget.embedded) {
      _homeBloc.add(InitializeHome());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeBloc,
      child: Scaffold(
        body: WatchFrame(
          enableWidget: (enable, opacity) {
            _homeBloc.add(ToggleScreen(enabled: enable, opacity: opacity));
          },
          content: WatchScreen(embedded: widget.embedded),
        ),
      ),
    );
  }
}
