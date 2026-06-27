part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool showScreens;
  final double contentOpacity;
  final bool bottomIsShowing;
  final int currentPageIndex;

  const HomeState({
    this.showScreens = true,
    this.contentOpacity = 1.0,
    this.bottomIsShowing = false,
    this.currentPageIndex = 0,
  });

  HomeState copyWith({
    bool? showScreens,
    double? contentOpacity,
    bool? bottomIsShowing,
    int? currentPageIndex,
  }) {
    return HomeState(
      showScreens: showScreens ?? this.showScreens,
      contentOpacity: contentOpacity ?? this.contentOpacity,
      bottomIsShowing: bottomIsShowing ?? this.bottomIsShowing,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
    );
  }

  @override
  List<Object> get props => [showScreens, contentOpacity, bottomIsShowing, currentPageIndex];
}
