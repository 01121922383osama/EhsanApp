import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:free_lancer/l10n/app_localizations.dart';

import '../../../../core/widgets/custom_appbar.dart';

BoxDecoration libraryCardDecoration(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    gradient: LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primary.withOpacity(0.12),
        Theme.of(context).colorScheme.primary.withOpacity(0.04),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  );
}

String libraryLoadingMessage(BuildContext context) {
  return AppLocalizations.of(context)?.loading ?? 'جاري التحميل...';
}

class LibraryCategoryCard extends StatelessWidget {
  final String title;
  final int itemCount;
  final IconData icon;
  final VoidCallback onTap;

  const LibraryCategoryCard({
    super.key,
    required this.title,
    required this.itemCount,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: libraryCardDecoration(context),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: Theme.of(context).colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$itemCount',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$itemCount عنصر',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LibraryContentCard extends StatelessWidget {
  final Widget child;
  final int? index;

  const LibraryContentCard({
    super.key,
    required this.child,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: libraryCardDecoration(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != null) ...[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class LibraryEmptyView extends StatelessWidget {
  const LibraryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 56,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            'لا توجد بيانات',
            style: Theme.of(context).textTheme.titleMedium,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

class LibraryErrorView extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const LibraryErrorView({
    super.key,
    this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              error?.toString() ?? 'حدث خطأ',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 50.ms);
  }
}

class LibraryLoadingView extends StatelessWidget {
  final String? message;

  const LibraryLoadingView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textDirection: TextDirection.rtl,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 50.ms);
  }
}

class LibraryPageScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const LibraryPageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        centerTitle: true,
        title: Text(title)
            .animate()
            .fadeIn(duration: 50.ms)
            .slideX(begin: -0.15, end: 0, duration: 50.ms),
        actions: actions,
      ),
      body: body,
    );
  }
}

class LibrarySearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hint;

  const LibrarySearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.clear_rounded),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              );
            },
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    ).animate().fadeIn(duration: 50.ms).slideY(begin: -0.1, end: 0);
  }
}
