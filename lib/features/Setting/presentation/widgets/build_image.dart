import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/extension/extension.dart';
import '../cubit/Theme/theme_cubit.dart';

class BuildImageWidget extends StatelessWidget {
  const BuildImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, state) {
        return Card(
          color: context.read<ThemeCubit>().state
              ? Colors.transparent
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: context.width * 0.30,
                      height: context.width * 0.30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/person.png'),
                        ),
                      ),
                    ).animate().shake().shimmer(),
                    CustomPaint(
                      painter: DrowLineCircle(),
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  AppLocalizations.of(context)!.titleApp,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'EhsanApp@gmail.com',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DrowLineCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.grey;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
