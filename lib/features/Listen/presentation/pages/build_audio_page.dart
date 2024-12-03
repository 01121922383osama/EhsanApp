import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/extension/extension.dart';
import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../Quran/presentation/widgets/search_delegate.dart';
import '../../../Setting/presentation/cubit/Theme/theme_cubit.dart';
import '../../data/models/models_urls.dart';
import '../widgets/AudioHelper/get_all_surah_from_audio.dart';
import '../widgets/AudioHelper/get_name_of_audio.dart';
import '../widgets/AudioHelper/get_seek_bar.dart';
import '../widgets/AudioHelper/icon_repeat_icon_shuffle.dart';
import '../widgets/AudioHelper/position_data.dart';
import 'audio_controler.dart';

class BuildAudioPage extends StatefulWidget {
  final List<Urls>? audioUrl;

  const BuildAudioPage({
    super.key,
    this.audioUrl,
  });

  @override
  State<BuildAudioPage> createState() => _BuildAudioPageState();
}

class _BuildAudioPageState extends State<BuildAudioPage> {
  late AudioPlayer audioPlayer;
  late ConcatenatingAudioSource _playlist;
  late StreamSubscription<PlayerState> _playerStateSubscription;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _playlist = _initAudio();
    _playerStateSubscription = audioPlayer.playerStateStream.listen(
        (PlayerState state) {},
        onError: (Object e, StackTrace stackTrace) {});
    try {
      await audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                'Failed to load audio source: $e',
                textAlign: TextAlign.center,
              ),
            ),
          );
      }
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _playerStateSubscription.cancel();
    super.dispose();
  }

  ConcatenatingAudioSource _initAudio() {
    return ConcatenatingAudioSource(
      children: List.generate(
        quranList.length,
        (index) {
          return AudioSource.uri(
            Uri.parse(widget.audioUrl![index].audioUrl),
            tag: MediaItem(
              id: '${index + 1}',
              title: quranList[index].surahArabic!,
              album: widget.audioUrl![index].title1,
            ),
          );
        },
      ),
    );
  }

  Stream<PositionData> get _positionDataStream {
    return Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      audioPlayer.positionStream,
      audioPlayer.bufferedPositionStream,
      audioPlayer.durationStream,
      (position, bufferedPosition, duration) {
        return PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        leading: const BuildIconBackWidget(),
        title: GetNameOfAudio(
          audioPlayer: audioPlayer,
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ThemeCubit, bool>(
                builder: (context, state) {
                  return CustomScrollView(
                    primary: true,
                    cacheExtent: 10000,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: GetAllSurahWidget(
                          audioPlayer: audioPlayer,
                          audioUrl: quranList,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.height * 0.05),
                    topRight: Radius.circular(context.height * 0.05),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GetSeekBarWidget(
                      audioPlayer: audioPlayer,
                      positionDataStream: _positionDataStream,
                    ),
                    IconRepeatIconShuffle(
                      audioPlayer: audioPlayer,
                    ),
                    ControlButtons(
                      audioPlayer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
