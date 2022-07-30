part of 'title_screen_bloc.dart';

abstract class TitleScreenEvent extends Equatable {
  const TitleScreenEvent();
}

class HomeTitleEvent extends TitleScreenEvent{
  @override
  List<Object?> get props => [];
}