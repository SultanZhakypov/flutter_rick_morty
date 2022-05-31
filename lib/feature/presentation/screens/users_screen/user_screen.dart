import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_project/feature/bloc/rickmorty_bloc.dart';
import 'package:rick_and_morty_project/feature/models/user_model.dart';
import 'package:rick_and_morty_project/feature/presentation/providers/rick_provider.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/detail_screen/detail_screen.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/filter_screen/filter_screen.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/main_screen/main_screen.dart';
import 'package:rick_and_morty_project/feature/presentation/widgets/app_unfocuser.dart';
import 'package:rick_and_morty_project/feature/presentation/widgets/list_gridview.dart';
import 'package:rick_and_morty_project/resources/app_colors.dart';
import 'package:rick_and_morty_project/resources/resources.dart';

part '../../widgets/app_bar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    return AppUnfocuser(
      child: Scaffold(
        backgroundColor: AppColors.backgroudColor,
        appBar: DefaultAppBar(),
        body: BlocBuilder<RickmortyBloc, RickmortyState>(
          builder: (context, state) {
            if (state is RickmortyLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (state is RickmortySuccessState) {
              return UserItems(
                isLoading: state.isLoading,
                key: const PageStorageKey('1'),
                models: state.models,
              );
            }
            if (state is RickmortyErrorState) {
              return Center(
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  children: [
                    Image.asset(
                      Images.nodata,
                      height: 224,
                      width: 134,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Text(
                      'По данным фильтра ничего \n      не найдено',
                      style: AppColors.errorstateText.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: 0.15,
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class UserItems extends StatefulWidget {
  const UserItems({
    Key? key,
    required this.models,
    required this.isLoading,
  }) : super(key: key);

  final List<Results> models;
  final bool isLoading;

  @override
  State<UserItems> createState() => _UserItemsState();
}

class _UserItemsState extends State<UserItems> {
  int pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    bool nextPage = widget.isLoading;
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        final current = notification.metrics.pixels + 100;
        final max = notification.metrics.maxScrollExtent;
        if (current >= max && !nextPage) {
          nextPage = true;
          pageNumber++;
          BlocProvider.of<RickmortyBloc>(context)
              .add(GetUserEvent(pageNumber: pageNumber));
        }
        return true;
      },
      child: vm.isGridview
          ? GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: widget.models.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        id: widget.models[index].id ?? 0,
                      ),
                    ),
                  );
                },
                child: ListGridView(
                  name: widget.models[index].name ?? '',
                  status: widget.models[index].status ?? '',
                  gender: widget.models[index].gender ?? '',
                  species: widget.models[index].species ?? '',
                  image: widget.models[index].image ?? '',
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: widget.models.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 24,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          id: widget.models[index].id ?? 0,
                        ),
                      ),
                    );
                  },
                  child: ListItem(
                    name: widget.models[index].name ?? '',
                    status: widget.models[index].status ?? '',
                    gender: widget.models[index].gender ?? '',
                    species: widget.models[index].species ?? '',
                    image: widget.models[index].image ?? '',
                  ),
                );
              },
            ),
    );
  }
}
