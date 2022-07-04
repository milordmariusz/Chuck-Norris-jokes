import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final ChuckJokeService _chuckJokeService;

  HomeBloc(this._chuckJokeService) : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final chuckJoke = await _chuckJokeService.getChuckJoke();
      emit(HomeLoadedState(chuckJoke.value.id,chuckJoke.value.joke));
    });
  }
}
