import 'package:auto_size_text/auto_size_text.dart';
import 'package:chuck_norris_jokes_api/home/bloc/home_bloc.dart';
import 'package:chuck_norris_jokes_api/home/home_colors.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';
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
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: AutoSizeText(
                        state.joke.replaceAll("&quot;", "\""),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: HomeColors.textWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                        LoadApiEvent(),
                      ),
                      child: const Text("Next one"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Return"),
                    )
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
