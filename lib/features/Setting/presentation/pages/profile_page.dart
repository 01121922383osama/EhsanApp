import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:free_lancer/features/Setting/presentation/cubit/ChangeFonts/change_fonts.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../core/extension/blurry_widget.dart';
import '../../../../core/extension/extension.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/animation_colors.dart';
import '../../../app/presentation/cubit/app_cubit.dart';
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
                // ListTile(
                //   title: Text(AppLocalizations.of(context)!.notifications),
                //   leading: const Icon(Icons.notifications),
                //   trailing: Switch.adaptive(
                //     value: true,
                //     onChanged: (value) {},
                //   ),
                // ),
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
                  title: const Text('حجم الخط'),
                  leading: const Icon(Icons.font_download),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AnimationColorsContainer(
                          child: AlertDialog.adaptive(
                            shadowColor: AppColors.white,
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
                                            activeColor: Colors.brown,
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
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            BuildSettingsWidget(
              widgets: [
                // ListTile(
                //   title: Text(AppLocalizations.of(context)!.helper),
                //   leading: const Icon(Icons.help),
                //   trailing: Text(AppLocalizations.of(context)!.info),
                // ),
                // ListTile(
                //   title: Text(AppLocalizations.of(context)!.privacyPolicy),
                //   leading: const Icon(Icons.privacy_tip),
                //   trailing: Text(AppLocalizations.of(context)!.private),
                // ),
                // ListTile(
                //   title: Text(AppLocalizations.of(context)!.contactUs),
                //   leading: const Icon(Icons.contact_page),
                //   trailing: Text(AppLocalizations.of(context)!.contact),
                // ),

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

class BuildSettingsWidget extends StatelessWidget {
  final List<Widget> widgets;
  const BuildSettingsWidget({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        color: AppColors.transparent,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widgets.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return widgets[index];
          },
        ).blurry(blur: 50),
      ),
    );
  }
}

void logOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AnimationColorsContainer(
        child: AlertDialog.adaptive(
          backgroundColor: context.read<ThemeCubit>().state
              ? AppColors.darkBlue
              : AppColors.white,
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
        ),
      );
    },
  );
}
