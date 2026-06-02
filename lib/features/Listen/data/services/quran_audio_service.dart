import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import '../../../Quran/presentation/widgets/search_delegate.dart';
import '../../presentation/widgets/AudioHelper/position_data.dart';
import '../models/models_urls.dart';

class QuranAudioService {
  final AudioPlayer player = AudioPlayer();

  List<Urls>? currentUrls;
  String? _playlistKey;
  bool _sessionConfigured = false;
  QuranAudioService();

  bool get hasActiveSession => currentUrls != null;

  Stream<PositionData> get positionDataStream {
    return Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      player.positionStream,
      player.bufferedPositionStream,
      player.durationStream,
      (position, bufferedPosition, duration) {
        return PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        );
      },
    );
  }

  Future<void> loadPlaylist(List<Urls> urls) async {
    await _ensureSession();
    final key = _playlistKeyFor(urls);
    if (_playlistKey == key) {
      currentUrls = urls;
      return;
    }

    _playlistKey = key;
    currentUrls = urls;

    final playlist = ConcatenatingAudioSource(
      children: List.generate(
        quranList.length,
        (index) => AudioSource.uri(
          Uri.parse(urls[index].audioUrl),
          tag: MediaItem(
            id: 'surah_${index + 1}',
            title: quranList[index].surahArabic ?? '',
            album: urls[index].title1,
          ),
        ),
      ),
    );

    await player.setAudioSource(playlist);
  }

  Future<void> _ensureSession() async {
    if (_sessionConfigured) return;
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    _sessionConfigured = true;
  }

  String _playlistKeyFor(List<Urls> urls) =>
      urls.map((url) => url.audioUrl).join('\u0001');
}
