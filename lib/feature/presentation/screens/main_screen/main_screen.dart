import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_project/feature/presentation/providers/rick_provider.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/episodes_screen/episodes_screen.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/location_screen/location_screen.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/settings_screen/settings_screen.dart';
import 'package:rick_and_morty_project/feature/presentation/screens/users_screen/user_screen.dart';
import 'package:rick_and_morty_project/resources/app_colors.dart';
import 'package:rick_and_morty_project/resources/resources.dart';

part "../../widgets/list_item.dart";

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static List<Widget> pages = [
    const UserScreen(),
    const LocationScreen(),
    const EpisodesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: pages[vm.currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: AppColors.textfieldColor,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          onTap: vm.currentindex,
          type: BottomNavigationBarType.fixed,
          currentIndex: vm.currentIndex,
          unselectedItemColor: const Color(0xff5B6975),
          fixedColor: const Color(0xff43D049),
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Svgs.homepage,
                  color: vm.currentIndex == 0
                      ? AppColors.selectedColorNavBar
                      : AppColors.unselectedColorNavBar,
                ),
                label: 'Персонажи'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Svgs.location,
                  color: vm.currentIndex == 1
                      ? AppColors.selectedColorNavBar
                      : AppColors.unselectedColorNavBar,
                ),
                label: 'Локации'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Svgs.episodes,
                  color: vm.currentIndex == 2
                      ? AppColors.selectedColorNavBar
                      : AppColors.unselectedColorNavBar,
                ),
                label: 'Эпизоды'),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Svgs.settings,
                  color: vm.currentIndex == 3
                      ? AppColors.selectedColorNavBar
                      : AppColors.unselectedColorNavBar,
                ),
                label: 'Настройки'),
          ],
        ),
      ),
    );
  }
}
