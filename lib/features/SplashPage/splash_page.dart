import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/routes/routes_name.dart';
import '../../core/extension/extension.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/assets_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1300), () {
      context.pushNamedAndRemoveUntil(pageRoute: RoutesName.loginscreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                AssetsSvg.backgroundRed,
              ),
            ),
            Center(
              child: SvgPicture.asset(
                AssetsSvg.mushaf,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
