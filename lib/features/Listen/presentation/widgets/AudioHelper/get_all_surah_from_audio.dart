import 'package:flutter/material.dart';
import '../../../../Quran/presentation/widgets/leading_widget.dart';
import 'package:just_audio/just_audio.dart';

class GetAllSurahWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const GetAllSurahWidget({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        final sequence = state?.sequence ?? [];
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: sequence.length,
            itemBuilder: (context, index) {
              return Material(
                color:
                    index == state!.currentIndex ? Colors.grey.shade300 : null,
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
          ),
        );
      },
    );
  }
}
