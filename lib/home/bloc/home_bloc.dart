import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';

import '../../services/connectivity_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final ChuckJokeService _chuckJokeService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._chuckJokeService, this._connectivityService) : super(HomeLoadingState()) {
    _connectivityService.connectivityStream.stream.listen((event) {
      if(event == ConnectivityResult.none) {
        print("internet: no");
        add(NoInternetEvent());
      }
      else{
        print("internet: yes");
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final chuckJoke = await _chuckJokeService.getChuckJoke();
      emit(HomeLoadedState(chuckJoke.value.id,chuckJoke.value.joke));
    });

    on<NoInternetEvent>((event, emit){
      emit(HomeNoInternetState());
    });
  }
}
