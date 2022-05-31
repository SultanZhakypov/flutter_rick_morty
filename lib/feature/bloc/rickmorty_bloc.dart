import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rick_and_morty_project/feature/models/detail_model.dart';
import 'package:rick_and_morty_project/feature/models/repository/user_repo.dart';
import 'package:rick_and_morty_project/feature/models/user_model.dart';

class RickmortyBloc extends Bloc<RickmortyEvent, RickmortyState> {
  RickmortyBloc({required this.repo}) : super(RickmortyInitialState()) {
    on<GetUserEvent>((event, emit) async {
      if ((event.pageNumber ?? 1) <= maxPage) {
        emit(RickmortySuccessState(
          isLoading: true,
          models: allCharacters,
          detail: DetailModel(),
        ));
        try {
          final result = await repo.getUsers(
              name: event.name ?? '', pageNumber: event.pageNumber ?? 1);

          if (!event.isForSearch) {
            allCharacters.addAll(result.results ?? []);
            maxPage = result.info?.pages ?? 1;

            emit(
              RickmortySuccessState(
                isLoading: false,
                models: allCharacters,
                detail: DetailModel(),
              ),
            );
          } else {
            emit(
              RickmortySuccessState(
                isLoading: false,
                models: result.results ?? [],
                detail: DetailModel(),
              ),
            );
          }
        } catch (e) {
          emit(RickmortyErrorState());
        }
      }
    });
    on<GetDetailUserEvent>((event, emit) async {
      emit(RickmortyLoadingState());
      try {
        final result = await repo.getDetailUsers(id: event.id);
        emit(
          RickmortySuccessState(
            isLoading: false,
            models: const [],
            detail: result,
          ),
        );
      } catch (e) {
        emit(RickmortyErrorState());
      }
    });
    

  }

  final UserRepo repo;
  int maxPage = 1;

  List<Results> allCharacters = [];
}

@immutable
abstract class RickmortyEvent {}

class GetUserEvent extends RickmortyEvent {
  GetUserEvent({this.name, this.pageNumber, this.isForSearch = false});
  final String? name;
  final int? pageNumber;
  final bool isForSearch;
}

class GetDetailUserEvent extends RickmortyEvent {
  GetDetailUserEvent({
    required this.id,
  });

  final int id;
}




@immutable
abstract class RickmortyState {}

class RickmortyInitialState extends RickmortyState {}

class RickmortyLoadingState extends RickmortyState {}

class RickmortySuccessState extends RickmortyState {
  RickmortySuccessState({
    required this.models,
    required this.detail,
    required this.isLoading,
  });
  final List<Results> models;
  final DetailModel detail;
  final bool isLoading;
}

class RickmortyErrorState extends RickmortyState {}
