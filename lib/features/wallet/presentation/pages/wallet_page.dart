import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_watch/commons/colors.dart';
import 'package:smart_watch/commons/extension.dart';
import 'package:smart_watch/commons/size/size.dart';
import 'package:smart_watch/commons/widgets/pointers.dart';
import 'package:smart_watch/core/injection_container/injection_container.dart';
import 'package:smart_watch/core/presentation/bloc/weather/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final bloc = injectionInstance<WeatherBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack(),
      body: GestureDetector(
        onPanUpdate: (details) {
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: width(context) * .72,
          height: width(context) * .72,
          child: BlocProvider.value(
            value: bloc,
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is InitialState || state is ProgressState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is SuccessState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Pointers.fullHour(context, fontSize: width(context)*.05),
                      SizedBox(height: height(context) * .01),
                      Text(
                        "${state.country}, ${state.area}"
                            .capitalizeEveryFirstLetter,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height(context) * .01),
                      Text(
                        state.description!.capitalizeEveryFirstLetter,
                        style: TextStyle(color: Colors.white),
                      ),
                      getTemperature(state),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${state.maxTemperature!.round()}º",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: width(context) * .03),
                          Text(
                            "${state.minTemperature!.round()}º",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if(bloc.forecast!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 42.0, right: 42.0,),
                          child: SizedBox(
                            width: width(context) * .72,
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: bloc.forecast!.length,
                              itemBuilder: (context, index){
                                return SizedBox(
                                  width: width(context) *.3,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(DateFormat('EEE').format(bloc.forecast![index].date!),
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                      CachedNetworkImage(
                                        imageUrl:
                                        "http://openweathermap.org/img/wn/${bloc.forecast![index].weatherIcon}@2x.png",
                                        width: 35,
                                        height: 35,
                                        placeholder: (context, url) =>
                                            Center(child: CircularProgressIndicator()),
                                      ),
                                      Text(
                                        "${bloc.forecast![index].temperature!.celsius!.round()}º",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height(context) * .02),
                      Icon(
                        state.props.first as IconData,
                        color: Colors.white,
                      ),
                      SizedBox(height: height(context) * .02),
                      Text(
                        state.props.last.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Row getTemperature(SuccessState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl:
          "http://openweathermap.org/img/wn/${state.weatherIcon}@2x.png",
          width: 70,
          height: 70,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
        ),
        Text(
          "${state.temperature!.round()}º",
          style: TextStyle(
            fontSize: 34,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
