part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}


class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState{
  final int id;
  final String joke;

  const HomeLoadedState(this.id, this.joke);

  @override
  List<Object?> get props => [id,joke];
}

class HomeNoInternetState extends HomeState{
  @override
  List<Object?> get props => [];
}