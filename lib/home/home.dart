import 'package:chuck_norris_jokes_api/home/bloc/home_bloc.dart';
import 'package:chuck_norris_jokes_api/services/chuck_joke_service.dart';
import 'package:chuck_norris_jokes_api/services/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Chuck Norris jokes"),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(LoadApiEvent()),
                          child: Text("Load joke"))
                    ],
                  ),
                );
              }
              if (state is HomeLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoadedState) {
                return Column(
                  children: [
                    Text(state.joke),
                    Text(state.id.toString()),
                    ElevatedButton(
                        onPressed: () => BlocProvider.of<HomeBloc>(context)
                            .add(LoadApiEvent()),
                        child: Text("Next one")),
                    ElevatedButton(
                        onPressed: () => BlocProvider.of<HomeBloc>(context)
                            .add(HomeTitleEvent()),
                        child: Text("Return"))
                  ],
                );
              }
              if (state is HomeNoInternetState) {
                return Text("no internet");
              }
              return Container();
            },
          ),
        ));
  }
}
