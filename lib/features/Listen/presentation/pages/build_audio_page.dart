import 'package:flutter/material.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../injection_container.dart';
import '../../data/models/models_urls.dart';
import '../../data/services/quran_audio_service.dart';
import '../widgets/AudioHelper/get_all_surah_from_audio.dart';
import '../widgets/AudioHelper/get_name_of_audio.dart';
import '../widgets/AudioHelper/get_seek_bar.dart';
import '../widgets/AudioHelper/icon_repeat_icon_shuffle.dart';
import '../widgets/listen_ui.dart';
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
  late final QuranAudioService _audioService;
  bool _isLoading = true;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final player = _audioService.player;

    return Scaffold(
      appBar: CustomAppbar(
        leading: const BuildIconBackWidget(),
        centerTitle: true,
        title: GetNameOfAudio(
          audioPlayer: player,
          compact: true,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _isLoading
            ? const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              )
            : _error != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _error!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: GetAllSurahWidget(
                                audioPlayer: player,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: ListenUi.playerPanel(
                          context,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GetSeekBarWidget(
                                audioPlayer: player,
                                positionDataStream:
                                    _audioService.positionDataStream,
                              ),
                              IconRepeatIconShuffle(
                                audioPlayer: player,
                              ),
                              ControlButtons(player),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _audioService = sl<QuranAudioService>();
    _loadPlaylist();
  }

  Future<void> _loadPlaylist() async {
    if (widget.audioUrl == null) {
      setState(() {
        _isLoading = false;
        _error = 'No audio source';
      });
      return;
    }

    try {
      await _audioService.loadPlaylist(widget.audioUrl!);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }
}
