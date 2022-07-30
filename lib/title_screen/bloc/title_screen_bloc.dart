import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'title_screen_event.dart';
part 'title_screen_state.dart';

class TitleScreenBloc extends Bloc<TitleScreenEvent, TitleScreenState> {
  TitleScreenBloc() : super(HomeTitleState()) {
    on<TitleScreenEvent>((event, emit) {
      emit(HomeTitleState());
    });
  }
}
