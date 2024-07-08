import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_svg.dart';
import '../../../Listen/presentation/widgets/build_menu_alshai5.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../../../app/presentation/cubit/app_cubit.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppState state;
  const BuildAppBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(15, 15),
        ),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<ThemeCubit, bool>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () =>
                        context.pushNamed(pageRoute: RoutesName.aboutUs),
                    child: SvgPicture.asset(
                      AssetsSvg.icon4,
                      colorFilter: ColorFilter.mode(
                        context.read<ThemeCubit>().state
                            ? AppColors.white
                            : AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  );
                },
              ),
              _buildMenu(context, state),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

Widget _buildMenu(BuildContext context, AppState state) {
  switch (state.index) {
    case 0:
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_active),
      );
    case 1:
      return IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_active),
      );
    case 2:
      return IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchMoshaf(),
          );
        },
        icon: const Icon(Icons.search),
      );
    case 3:
      return const TextButton(
        onPressed: null,
        child: Text(''),
      );
    default:
      return const SizedBox.shrink();
  }
}
