import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ChuckJokeService _chuckJokeService;
  StreamSubscription? subscription;

  HomeBloc(this._chuckJokeService)
      : super(HomeLoadingState()) {

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        add(NoInternetEvent());
      } else {
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final chuckJoke = await _chuckJokeService.getChuckJoke();
      emit(HomeLoadedState(chuckJoke.value.id, chuckJoke.value.joke));
    });

    on<NoInternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
