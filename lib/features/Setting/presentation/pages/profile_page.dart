import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:free_lancer/features/Setting/presentation/widgets/build_setting_widget.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../app/presentation/cubit/app_cubit.dart';
import '../cubit/ChangeFonts/change_fonts.dart';
import '../cubit/Lang/change_language_cubit.dart';
import '../cubit/Theme/theme_cubit.dart';
import '../widgets/build_image.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: BuildImageWidget(),
            ),
            BuildSettingsWidget(
              widgets: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.lang),
                  leading: const Icon(Icons.language),
                  trailing: PopupMenuButton<int>(
                    onSelected: (int value) {
                      switch (value) {
                        case 0:
                          context
                              .read<ChangeLanguageCubit>()
                              .changeLang(lang: 'ar');
                          break;
                        case 1:
                          context
                              .read<ChangeLanguageCubit>()
                              .changeLang(lang: 'en');
                          break;
                        case 2:
                          context
                              .read<ChangeLanguageCubit>()
                              .changeLang(lang: 'fr');
                          break;
                      }
                    },
                    color: context.read<ThemeCubit>().state
                        ? Colors.black
                        : Colors.white,
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(AppLocalizations.of(context)!.arabic),
                        ),
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text(AppLocalizations.of(context)!.english),
                        ),
                        PopupMenuItem<int>(
                          value: 2,
                          child: Text(AppLocalizations.of(context)!.french),
                        ),
                      ];
                    },
                  ),
                ),
                BlocBuilder<ThemeCubit, bool>(
                  builder: (context, state) {
                    return ListTile(
                      title: Text(state
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light),
                      leading: Icon(state ? Icons.dark_mode : Icons.light_mode),
                      trailing: Switch.adaptive(
                        value: context.read<ThemeCubit>().state,
                        onChanged: (value) {
                          context.read<ThemeCubit>().changeTheme();
                        },
                      ),
                    );
                  },
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.fontsize),
                  leading: const Icon(Icons.font_download),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog.adaptive(
                          title: const Text('حجم الخط'),
                          content: BlocBuilder<ChangeFonts, double>(
                            builder: (context, state) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      const Text('18'),
                                      Expanded(
                                        child: Slider.adaptive(
                                          value: state,
                                          min: 18.0,
                                          max: 30.0,
                                          divisions: 12,
                                          onChanged: (value) {
                                            context
                                                .read<ChangeFonts>()
                                                .changeFont(value);
                                          },
                                        ),
                                      ),
                                      Text(state.floor().toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    AppLocalizations.of(context)!.holyQuran,
                                    style: TextStyle(
                                      fontSize: state,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          actionsAlignment: MainAxisAlignment.start,
                          actions: [
                            ElevatedButton(
                              onPressed: () => context.pop(),
                              child: const Text('حسنا'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            BuildSettingsWidget(
              widgets: [
                ListTile(
                  onTap: () {
                    logOut(context);
                  },
                  title: Text(AppLocalizations.of(context)!.logOut),
                  leading: const Icon(Icons.logout),
                  trailing: Text(AppLocalizations.of(context)!.logOut),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

void logOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog.adaptive(
        content: Text(
          AppLocalizations.of(context)!.areUsure,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              AppLocalizations.of(context)!.no,
              style: AppTextStyles.textStyleFont20,
            ),
          ),
          TextButton(
            onPressed: () {
              context.pushNamedAndRemoveUntil(
                  pageRoute: RoutesName.loginscreen);
              context.read<AppCubit>().changeIndex(0);
            },
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: AppTextStyles.textStyleFont20,
            ),
          ),
        ],
      );
    },
  );
}
