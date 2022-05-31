part of '../screens/users_screen/user_screen.dart';

class DefaultAppBar extends StatelessWidget with PreferredSizeWidget {
  DefaultAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<RickMortyProvider>(context);
    return AppBar(
      backgroundColor: AppColors.backgroudColor,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: DefaultTextField(
                  onChange: (value) {
                    BlocProvider.of<RickmortyBloc>(context)
                        .add(GetUserEvent(name: value, isForSearch: true));
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('ВСЕГО ПЕРСОНАЖЕЙ : 826',
                      style: AppColors.errorstateText),
                  IconButton(
                    onPressed: () {
                      vm.togridview();
                    },
                    icon: vm.isGridview
                        ? SvgPicture.asset(
                            Svgs.toListView,
                            fit: BoxFit.scaleDown,
                          )
                        : SvgPicture.asset(
                            Svgs.togridview,
                            fit: BoxFit.scaleDown,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(140);
}

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      style: const TextStyle(
        color: AppColors.hintColor,
        fontSize: 16,
        letterSpacing: 0.44,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        hintText: 'Найти персонажа',
        hintStyle: const TextStyle(
          color: AppColors.hintColor,
          fontSize: 16,
          letterSpacing: 0.44,
        ),
        prefixIcon: IconButton(
          icon: SvgPicture.asset(
            Svgs.search,
            fit: BoxFit.scaleDown,
          ),
          onPressed: () {},
        ),
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const VerticalDivider(
              color: AppColors.hintColor,
              indent: 14,
              endIndent: 14,
              width: 3,
            ),
            const SizedBox(
              height: 14,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => FilterScreen()),
                  ),
                );
              },
              icon: SvgPicture.asset(
                Svgs.filter,
                fit: BoxFit.scaleDown,
              ),
            ),
          ],
        ),
        fillColor: AppColors.textfieldColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
