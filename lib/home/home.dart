import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuck_norris_jokes_api/home/bloc/home_bloc.dart';
import 'package:chuck_norris_jokes_api/home/home_colors.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../title_screen/title_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<ChuckJokeService>(context),
      ),
      child: Scaffold(
        backgroundColor: HomeColors.backgroundColor,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: AutoSizeText(
                          state.joke.replaceAll("&quot;", "\""),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: HomeColors.textWhiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          minimumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width * 0.33, 40)),
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
                          backgroundColor: MaterialStateProperty.all(
                              HomeColors.backgroundColor),
                          overlayColor:
                              MaterialStateProperty.all(HomeColors.accentColor),
                        ),
                        onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                          LoadApiEvent(),
                        ),
                        child: const TitleScreenText(
                          content: 'Next one',
                          size: 25.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          minimumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width * 0.33, 40)),
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
                          backgroundColor: MaterialStateProperty.all(
                              HomeColors.backgroundColor),
                          overlayColor:
                              MaterialStateProperty.all(HomeColors.accentColor),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const TitleScreenText(
                          content: 'Return',
                          size: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is HomeNoInternetState) {
              return Container(
                decoration:
                    const BoxDecoration(color: HomeColors.backgroundColor),
                child: const Text("no internet"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
