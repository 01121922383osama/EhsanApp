import 'package:flutter/material.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/widgets/build_leading_widget.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../injection_container.dart';
import '../../../home/presentation/widgets/home_feature_ui.dart';
import '../../../home/presentation/widgets/home_prayer_ui.dart';
import '../../data/models/youtube_models.dart';
import '../../data/services/youtube_video_service.dart';
import 'youtube_section_page.dart';

class YoutubePage extends StatefulWidget {
  const YoutubePage({super.key});

  @override
  State<YoutubePage> createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  final _service = sl<YoutubeVideoService>();
  late Future<List<YoutubeSection>> _sectionsFuture;

  @override
  void initState() {
    super.initState();
    _sectionsFuture = _service.loadSections();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          l10n.youtubeTitle,
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: const BuildIconBackWidget(),
      ),
      body: FutureBuilder<List<YoutubeSection>>(
        future: _sectionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return HomeFeatureUi.compactLoading();
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return HomeFeatureUi.emptyState(context, l10n.tryAgain);
          }

          final sections = snapshot.data!;
          return Scrollbar(
            child: ListView(
              padding: HomeFeatureUi.pagePadding,
              children: [
                _AttributionBanner(text: l10n.youtubePoweredBy),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 1.05,
                  ),
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return _SectionCard(
                      section: section,
                      title: section.titleForLocale(locale),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => YoutubeSectionPage(section: section),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AttributionBanner extends StatelessWidget {
  const _AttributionBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(HomePrayerUi.radius),
        color: scheme.surfaceContainerHighest,
        border: Border.all(color: scheme.outline.withOpacity(0.12)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(Icons.play_circle_fill_rounded, color: Colors.red.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withOpacity(0.75),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.section,
    required this.title,
    required this.onTap,
  });

  final YoutubeSection section;
  final String title;
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
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 44,
                width: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red.shade50.withOpacity(
                    scheme.brightness == Brightness.dark ? 0.12 : 1,
                  ),
                  borderRadius: BorderRadius.circular(HomePrayerUi.radius),
                ),
                child: Icon(section.iconData, color: Colors.red.shade700, size: 24),
              ),
              const Spacer(),
              Text(
                title,
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
