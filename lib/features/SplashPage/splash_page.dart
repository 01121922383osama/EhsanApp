import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/routes/routes_name.dart';
import '../../core/extension/extension.dart';
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
      if (mounted) {
        context.pushNamedAndRemoveUntil(pageRoute: RoutesName.app);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
