part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeTitleEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class LoadApiEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class NoInternetEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}
