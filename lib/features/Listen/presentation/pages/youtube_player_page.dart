import 'dart:async';

import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../home/presentation/widgets/home_feature_ui.dart';
import '../../../home/presentation/widgets/home_prayer_ui.dart';
import '../../data/models/youtube_models.dart';
import '../widgets/youtube_video_thumbnail.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({
    super.key,
    required this.video,
    required this.sectionTitle,
  });

  final YoutubeVideo video;
  final String sectionTitle;

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  YoutubePlayerController? _controller;
  bool _playerActive = false;
  bool _playerFailed = false;
  bool _isLoading = false;
  StreamSubscription<YoutubePlayerValue>? _subscription;

  @override
  void dispose() {
    _subscription?.cancel();
    _controller?.close();
    super.dispose();
  }

  YoutubePlayerController _createController() {
    return YoutubePlayerController(
      key: widget.video.id,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
        playsInline: true,
        interfaceLanguage: 'ar',
      ),
      onWebResourceError: (_) {
        if (mounted) setState(() => _playerFailed = true);
      },
    );
  }

  Future<void> _startInAppPlayer() async {
    if (_isLoading) return;

    setState(() {
      _playerActive = true;
      _playerFailed = false;
      _isLoading = true;
    });

    _controller ??= _createController();
    _subscription ??= _controller!.listen((value) {
      if (value.hasError && mounted) {
        setState(() => _playerFailed = true);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _controller == null) return;
      try {
        await _controller!
            .loadVideoById(videoId: widget.video.id)
            .timeout(const Duration(seconds: 35));
        if (mounted) setState(() => _isLoading = false);
      } on TimeoutException {
        if (mounted) {
          setState(() {
            _playerFailed = true;
            _isLoading = false;
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() {
            _playerFailed = true;
            _isLoading = false;
          });
        }
      }
    });
  }

  Future<void> _openOnYoutube() async {
    final uri = Uri.parse('https://www.youtube.com/watch?v=${widget.video.id}');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          widget.sectionTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        leading: const BuildIconBackWidget(),
      ),
      body: ListView(
        padding: HomeFeatureUi.pagePadding,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(HomePrayerUi.radius),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildPlayerArea(context, l10n, scheme),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.video.title,
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
          ),
          if (widget.video.channelTitle != null &&
              widget.video.channelTitle!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              widget.video.channelTitle!,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withOpacity(0.65),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _openOnYoutube,
            icon: const Icon(Icons.open_in_new_rounded),
            label: Text(l10n.youtubeOpenExternal),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 10),
          _AttributionFooter(text: l10n.youtubePoweredBy),
        ],
      ),
    );
  }

  Widget _buildPlayerArea(
    BuildContext context,
    AppLocalizations l10n,
    ColorScheme scheme,
  ) {
    if (_playerFailed) {
      return _PlayerFallback(
        videoId: widget.video.id,
        message: l10n.youtubePlayerFailed,
        retryLabel: l10n.youtubePlayInApp,
        externalLabel: l10n.youtubeOpenExternal,
        onRetry: () {
          _controller?.close();
          _controller = null;
          _subscription?.cancel();
          _subscription = null;
          setState(() {
            _playerActive = false;
            _playerFailed = false;
          });
          _startInAppPlayer();
        },
        onExternal: _openOnYoutube,
      );
    }

    if (!_playerActive) {
      return _TapToPlayOverlay(
        videoId: widget.video.id,
        hint: l10n.youtubeTapToPlay,
        onTap: _startInAppPlayer,
      );
    }

    final controller = _controller ??= _createController();

    return Stack(
      fit: StackFit.expand,
      children: [
        YoutubePlayer(
          controller: controller,
          aspectRatio: 16 / 9,
          thumbnailFormat: ThumbnailFormat.jpeg,
          thumbnailQuality: ThumbnailQuality.medium,
        ),
        if (_isLoading)
          ColoredBox(
            color: scheme.scrim.withOpacity(0.35),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.loading,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.onInverseSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _TapToPlayOverlay extends StatelessWidget {
  const _TapToPlayOverlay({
    required this.videoId,
    required this.hint,
    required this.onTap,
  });

  final String videoId;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            YoutubeVideoThumbnail(
              videoId: videoId,
              showPlayIcon: false,
            ),
            ColoredBox(color: Colors.black.withOpacity(0.28)),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.white,
                    size: 64,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.surface.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(HomePrayerUi.radius),
                    ),
                    child: Text(
                      hint,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerFallback extends StatelessWidget {
  const _PlayerFallback({
    required this.videoId,
    required this.message,
    required this.retryLabel,
    required this.externalLabel,
    required this.onRetry,
    required this.onExternal,
  });

  final String videoId;
  final String message;
  final String retryLabel;
  final String externalLabel;
  final VoidCallback onRetry;
  final VoidCallback onExternal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.35,
            child: YoutubeVideoThumbnail(
              videoId: videoId,
              showPlayIcon: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded, size: 36, color: scheme.outline),
                const SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onRetry,
                        child: Text(retryLabel),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: onExternal,
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                        ),
                        child: Text(externalLabel),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttributionFooter extends StatelessWidget {
  const _AttributionFooter({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        color: scheme.surfaceContainerHighest,
        border: Border.all(color: scheme.outline.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_rounded, size: 16, color: Colors.red.shade700),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withOpacity(0.7),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
