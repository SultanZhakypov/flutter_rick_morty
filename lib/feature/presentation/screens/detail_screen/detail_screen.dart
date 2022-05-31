import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_project/feature/models/repository/user_repo.dart';
import 'package:rick_and_morty_project/feature/presentation/providers/rick_provider.dart';
import 'package:rick_and_morty_project/resources/app_colors.dart';
import '../../../bloc/rickmorty_bloc.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: BlocProvider.value(
        value: RickmortyBloc(repo: RepositoryProvider.of<UserRepo>(context))
          ..add(GetDetailUserEvent(id: id)),
        child: const DetailWidgets(),
      ),
    );
  }
}

class DetailWidgets extends StatelessWidget {
  const DetailWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    return BlocBuilder<RickmortyBloc, RickmortyState>(
      builder: (context, state) {
        if (state is RickmortySuccessState) {
          return SafeArea(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverPersistentHeader(
                    delegate: MySliverAppBar(
                      expandedHeight: 200,
                      image: state.detail.image ?? '',
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Text(
                        state.detail.name ?? '',
                        style: AppColors.nameStyle.copyWith(
                          fontSize: 34,
                          letterSpacing: 0.25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Center(
                      child: Text(
                        state.detail.status!.toUpperCase(),
                        style: AppColors.statusStyle.copyWith(
                          color: vm.colorStatus(state.detail.status ?? ''),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Flexible(
                      child: Text(
                        'Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери',
                        style: AppColors.detailscreenTextStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Пол',
                              style: AppColors.speciesAndGenderStyle,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              state.detail.gender ?? '',
                              style: AppColors.detailscreenTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 118,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Расса',
                              style: AppColors.speciesAndGenderStyle,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              state.detail.species ?? '',
                              style: AppColors.detailscreenTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Место рождения',
                              style: AppColors.speciesAndGenderStyle,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              state.detail.origin?.name ?? '',
                              style: AppColors.detailscreenTextStyle,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Местоположение',
                              style: AppColors.speciesAndGenderStyle,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              state.detail.location?.name ?? '',
                              style: AppColors.detailscreenTextStyle,
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    const Divider(
                      height: 2,
                      color: Color(0xff152A3A),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({
    required this.expandedHeight,
    required this.image,
  });
  final double expandedHeight;
  final String image;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ).blurred(
          blur: 2.5,
          blurColor: Colors.black,
          colorOpacity: 0.3,
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3.5,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: CircleAvatar(
              radius: 83,
              backgroundColor: AppColors.backgroudColor,
              child: CircleAvatar(
                radius: 73,
                backgroundImage: NetworkImage(image),
                child: const SizedBox(
                  height: 146,
                  width: 146,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;
  @override
  double get minExtent => kToolbarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
