import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/resources/app_colors.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: Center(
        child: Text('Episodes SCREEN'),
      ),
    );
  }
}
