import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_project/feature/presentation/providers/rick_provider.dart';
import 'package:rick_and_morty_project/resources/app_colors.dart';

class ListGridView extends StatelessWidget {
  const ListGridView({
    Key? key,
    required this.name,
    required this.status,
    required this.gender,
    required this.species,
    required this.image,
  }) : super(key: key);

  final String name;
  final String status;
  final String gender;
  final String species;
  final String image;

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    return SizedBox(
      height: 192,
      width: 192,
      child: Column(
        children: [
          
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(
            height: 17,
          ),
          Text(
            status.toUpperCase(),
            style: AppColors.statusStyle.copyWith(
              color: vm.colorStatus(status),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppColors.nameStyle.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '$species $gender',
            style: AppColors.speciesAndGenderStyle,
          ),
        ],
      ),
    );
  }
}
