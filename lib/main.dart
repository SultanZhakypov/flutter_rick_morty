import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_project/feature/bloc/rickmorty_bloc.dart';
import 'package:rick_and_morty_project/feature/data/dio_settings.dart';
import 'package:rick_and_morty_project/feature/models/repository/user_repo.dart';
import 'package:rick_and_morty_project/feature/presentation/providers/rick_provider.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/main_screen/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InitWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}

class InitWidget extends StatelessWidget {
  const InitWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DioSettings()),
        RepositoryProvider(
          create: (context) => UserRepo(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ((context) => RickmortyBloc(
                  repo: RepositoryProvider.of<UserRepo>(context),
                )..add(
                    GetUserEvent(),
                  )),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => RickMortyProvider(),
          child: child,
        ),
      ),
    );
  }
}
