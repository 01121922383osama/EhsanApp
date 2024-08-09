import 'package:flutter/material.dart';

import '../../../Listen/presentation/widgets/build_menu_alshai5.dart';
import '../cubit/app_cubit.dart';

Widget buildMenu(BuildContext context, AppState state) {
  switch (state.index) {
    case 0:
      return IconButton.outlined(
        onPressed: () {},
        icon: const Icon(Icons.notifications_active),
      );
    case 1:
      return const TextButton(
        onPressed: null,
        child: Text(''),
      );
    case 2:
      return IconButton.outlined(
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
