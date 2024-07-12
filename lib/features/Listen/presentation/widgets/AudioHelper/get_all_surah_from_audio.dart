import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Quran/data/models/quran_list_model.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../Quran/presentation/widgets/leading_widget.dart';
import '../../../../Setting/presentation/cubit/Theme/theme_cubit.dart';

class GetAllSurahWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final List<QuranList> audioUrl;

  const GetAllSurahWidget({
    super.key,
    required this.audioPlayer,
    required this.audioUrl,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final sequence = state?.sequence ?? [];
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: sequence.length,
          itemBuilder: (context, index) {
            return BlocBuilder<ThemeCubit, bool>(
              builder: (context, theme) {
                return Material(
                  color: theme
                      ? index == state!.currentIndex
                          ? Colors.grey.withOpacity(0.2)
                          : null
                      : index == state!.currentIndex
                          ? Colors.grey.shade300
                          : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ListTile(
                      leading: LeadingWidget(index: index),
                      title: Text(sequence[index].tag.title as String),
                      onTap: () {
                        audioPlayer.seek(Duration.zero, index: index);
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
