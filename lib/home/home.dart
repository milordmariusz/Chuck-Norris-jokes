import 'package:animated_background/animated_background.dart';
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
                return HomeTitlePage();
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

class HomeTitlePage extends StatefulWidget {
  const HomeTitlePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTitlePage> createState() => _HomeTitlePageState();
}

class _HomeTitlePageState extends State<HomeTitlePage> with TickerProviderStateMixin{
  ParticleOptions particles = ParticleOptions(
    image: Image.asset('assets/cowboy_hat.png'),
    baseColor: HomeColors.brownColor,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 30,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 70.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: HomeColors.backgroundColor,
      child: AnimatedBackground(
        behaviour: RandomParticleBehaviour(options: particles),
        vsync: this,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/chuck.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                const SizedBox(
                  height: 30,
                ),
                const TitleScreenText(
                  content: 'Chuck Norris',
                  size: 50.0,
                ),
                const TitleScreenText(
                  content: 'jokes',
                  size: 50.0,
                ),
                const SizedBox(
                  height: 50,
                ),
                const HomeButton(
                  content: 'Start',
                )
              ],
            ),
          ),
      ),
    );
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
          minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width * 0.33, 40)),
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
          backgroundColor:
              MaterialStateProperty.all(HomeColors.backgroundColor),
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
