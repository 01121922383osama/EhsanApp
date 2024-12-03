import 'package:flutter/material.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../Quran/presentation/widgets/build_avatar_surah.dart';

class YoutubePage extends StatelessWidget {
  const YoutubePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          'Youtube',
          style: TextStyle(
            color: Colors.red.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: const BuildIconBackWidget(),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.yellow.shade50.withOpacity(0.2),
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/hadith.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    alignment: Alignment.center,
                    height: 150,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.play_circle_fill,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: BuildAvatarNumber(index: index),
                    title: const Text('اسم الشيخ'),
                    subtitle: const Text('الوصف'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
