import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../injection_container.dart';
import '../../../home/presentation/widgets/home_feature_ui.dart';
import '../../../home/presentation/widgets/home_prayer_ui.dart';
import '../../data/models/youtube_models.dart';
import '../../data/services/youtube_video_service.dart';
import '../widgets/youtube_video_thumbnail.dart';
import 'youtube_player_page.dart';

class YoutubeSectionPage extends StatefulWidget {
  const YoutubeSectionPage({super.key, required this.section});

  final YoutubeSection section;

  @override
  State<YoutubeSectionPage> createState() => _YoutubeSectionPageState();
}

class _YoutubeSectionPageState extends State<YoutubeSectionPage> {
  final _service = sl<YoutubeVideoService>();
  late Future<List<YoutubeVideo>> _videosFuture;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    final locale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    _videosFuture = _service.getVideosForSection(
      widget.section,
      locale: locale,
    );
  }

  Future<void> _refresh() async {
    setState(_loadVideos);
    await _videosFuture;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final title = widget.section.titleForLocale(locale);

    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        leading: const BuildIconBackWidget(),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<YoutubeVideo>>(
          future: _videosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return HomeFeatureUi.compactLoading();
            }
            if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: HomeFeatureUi.emptyState(context, l10n.youtubeNoVideos),
                  ),
                ],
              );
            }

            final videos = snapshot.data!;
            return Scrollbar(
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: HomeFeatureUi.pagePadding,
                itemCount: videos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return _VideoTile(
                    video: video,
                    index: index,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => YoutubePlayerPage(
                          video: video,
                          sectionTitle: title,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VideoTile extends StatelessWidget {
  const _VideoTile({
    required this.video,
    required this.index,
    required this.onTap,
  });

  final YoutubeVideo video;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        child: Ink(
          decoration: HomeFeatureUi.neutralCardDecoration(context),
          padding: const EdgeInsets.all(8),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: YoutubeVideoThumbnail(
                  videoId: video.id,
                  width: 112,
                  height: 64,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      video.title,
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                    ),
                    if (video.channelTitle != null &&
                        video.channelTitle!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        video.channelTitle!,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: scheme.onSurface.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 6),
              HomeFeatureUi.indexBadge(context, index),
            ],
          ),
        ),
      ),
    );
  }
}
