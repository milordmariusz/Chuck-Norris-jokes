import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuck_norris_jokes_api/home/bloc/home_bloc.dart';
import 'package:chuck_norris_jokes_api/home/home_colors.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';
import 'package:chuck_norris_jokes_api/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(
              RepositoryProvider.of<ChuckJokeService>(context),
              RepositoryProvider.of<ConnectivityService>(context),
            ),
        child: Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeTitleState) {
                return Container(
                  decoration:
                      const BoxDecoration(color: HomeColors.backgroundColor),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        TitleScreenText(
                          content: 'Chuck Norris',
                          size: 50.0,
                        ),
                        TitleScreenText(
                          content: 'jokes',
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        HomeButton(
                          content: 'Start',
                        )
                      ],
                    ),
                  ),
                );
              }
              if (state is HomeLoadingState) {
                return Container(
                  decoration:
                      const BoxDecoration(color: HomeColors.backgroundColor),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is HomeLoadedState) {
                return Container(
                  decoration:
                      const BoxDecoration(color: HomeColors.backgroundColor),
                  child: Column(
                    children: [
                      Text(state.joke),
                      Text(state.id.toString()),
                      ElevatedButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(LoadApiEvent()),
                          child: const Text("Next one")),
                      ElevatedButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(HomeTitleEvent()),
                          child: const Text("Return"))
                    ],
                  ),
                );
              }
              if (state is HomeNoInternetState) {
                return Container(
                    decoration:
                        const BoxDecoration(color: HomeColors.backgroundColor),
                    child: const Text("no internet"));
              }
              return Container();
            },
          ),
        ));
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.33, 40)),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: HomeColors.textWhiteColor,
              width: 5,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(HomeColors.backgroundColor),
          overlayColor: MaterialStateProperty.all(HomeColors.accentColor),
        ),
        onPressed: () => BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
        child: const TitleScreenText(
          content: 'Start',
          size: 25.0,
        ),
      ),
    );
  }
}

class TitleScreenText extends StatelessWidget {
  const TitleScreenText({
    Key? key,
    required this.content,
    required this.size,
  }) : super(key: key);

  final String content;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      content,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: HomeColors.textWhiteColor,
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: 1,
    );
  }
}
