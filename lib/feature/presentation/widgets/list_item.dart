part of '../screens/main_screen/main_screen.dart';

class ListItem extends StatelessWidget {
  const ListItem({
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 74,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 37,
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(
              width: 18,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status.toUpperCase(),
                  style: AppColors.statusStyle.copyWith(
                    color: vm.colorStatus(status),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppColors.nameStyle,
                  ),
                ),
                Text(
                  '$species $gender',
                  style: AppColors.speciesAndGenderStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
