import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:rick_and_morty_project/feature/presentation/providers/rick_provider.dart';
import 'package:rick_and_morty_project/resources/app_colors.dart';
import 'package:rick_and_morty_project/resources/resources.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroudColor,
        title: const Text(
          'Фильтры',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'СОРТИРОВАТЬ',
              style: AppColors.textApperanceOverline,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const Text(
                  'По алфавиту',
                  style: AppColors.textApperanceSubtitle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    vm.checked = vm.checked;
                    vm.update();
                  },
                  icon: SvgPicture.asset(
                    Svgs.alphabetSelected,
                    color: vm.checked
                        ? const Color(0xff22A2BD)
                        : const Color(0xff5B6975),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: () {
                    vm.checked = !vm.checked;
                    vm.update();
                  },
                  icon: SvgPicture.asset(
                    Svgs.alphabetUnselected,
                    color: vm.checked
                        ? const Color(0xff5B6975)
                        : const Color(0xff22A2BD),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                height: 2,
                color: Color(0xff152a3a),
              ),
            ),
            const Text(
              'СТАТУС',
              style: AppColors.textApperanceOverline,
            ),
            const SizedBox(
              height: 20,
            ),
            const MyCheckBox(
              title: 'Живой',
            ),
            const MyCheckBox(
              title: 'Мертвый',
            ),
            const MyCheckBox(
              title: 'Неизвестный',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 36),
              child: Divider(
                height: 2,
                color: Color(0xff152a3a),
              ),
            ),
            const Text(
              'ПОЛ',
              style: AppColors.textApperanceOverline,
            ),
            const SizedBox(
              height: 20,
            ),
            const MyCheckBox(
              title: 'Мужской',
            ),
            const MyCheckBox(
              title: 'Женский',
            ),
            const MyCheckBox(
              title: 'Унисекс',
            ),
          ],
        ),
      ),
    );
  }
}

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            checkColor: AppColors.backgroudColor,
            activeColor: const Color(0xff22A2BD),
            value: ischecked,
            onChanged: (value) {
              ischecked = value!;
              setState(() {});
            }),
        const SizedBox(
          width: 17,
        ),
        Text(
          widget.title,
          style: AppColors.textApperanceSubtitle,
        )
      ],
    );
  }
}
