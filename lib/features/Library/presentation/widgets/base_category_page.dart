import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extension/extension.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/models/category_model.dart';
import 'library_shared_widgets.dart';

class BaseCategoryDetailPage extends StatefulWidget {
  final CategoryModel category;
  final Widget Function(BuildContext, CategoryItem) buildItemWidget;
  final bool enableSearch;

  const BaseCategoryDetailPage({
    super.key,
    required this.category,
    required this.buildItemWidget,
    this.enableSearch = true,
  });

  @override
  State<BaseCategoryDetailPage> createState() => _BaseCategoryDetailPageState();
}

class BaseCategoryPage extends StatefulWidget {
  final String title;
  final IconData icon;
  final Future<List<CategoryModel>> Function() loadCategories;
  final Widget Function(BuildContext, CategoryModel) buildDetailPage;
  final bool enableSearch;

  const BaseCategoryPage({
    super.key,
    required this.title,
    required this.icon,
    required this.loadCategories,
    required this.buildDetailPage,
    this.enableSearch = true,
  });

  @override
  State<BaseCategoryPage> createState() => _BaseCategoryPageState();
}

class _BaseCategoryDetailPageState extends State<BaseCategoryDetailPage> {
  final _searchController = TextEditingController();
  String _query = '';

  List<CategoryItem> get _filteredItems {
    if (_query.trim().isEmpty) return widget.category.items;
    final q = _query.trim();
    return widget.category.items
        .where((item) => item.text.contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return LibraryPageScaffold(
      title: widget.category.category,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          if (widget.enableSearch)
            SliverToBoxAdapter(
              child: LibrarySearchField(
                controller: _searchController,
                hint: AppLocalizations.of(context)!.search,
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.layers_rounded,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${widget.category.items.length} ${AppLocalizations.of(context)!.elements}',
                    style: Theme.of(context).textTheme.labelLarge,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
          ),
          if (items.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: LibraryEmptyView(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = items[index];
                    return LibraryContentCard(
                      index: index + 1,
                      child: widget.buildItemWidget(context, item),
                    )
                        .animate(delay: (30 * index).ms)
                        .fadeIn(duration: 50.ms)
                        .slideX(begin: 0.08, end: 0, duration: 50.ms);
                  },
                  childCount: items.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class _BaseCategoryPageState extends State<BaseCategoryPage> {
  late Future<List<CategoryModel>> _future;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return LibraryPageScaffold(
      title: widget.title,
      body: FutureBuilder<List<CategoryModel>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LibraryLoadingView(message: libraryLoadingMessage(context));
          }

          if (snapshot.hasError) {
            return LibraryErrorView(
              error: snapshot.error,
              onRetry: _reload,
            );
          }

          final categories = snapshot.data ?? [];
          if (categories.isEmpty) {
            return const LibraryEmptyView();
          }

          final filtered = _filter(categories);

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              if (widget.enableSearch)
                SliverToBoxAdapter(
                  child: LibrarySearchField(
                    controller: _searchController,
                    hint: AppLocalizations.of(context)!.search,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
              if (filtered.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: LibraryEmptyView(),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.88,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = filtered[index];
                        return LibraryCategoryCard(
                          title: category.category,
                          itemCount: category.items.length,
                          icon: widget.icon,
                          onTap: () => context.push(
                            widget: widget.buildDetailPage(context, category),
                          ),
                        )
                            .animate(delay: (40 * index).ms)
                            .fadeIn(duration: 50.ms)
                            .scale(
                              begin: const Offset(0.94, 0.94),
                              end: const Offset(1, 1),
                              duration: 50.ms,
                            );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _future = widget.loadCategories();
  }

  List<CategoryModel> _filter(List<CategoryModel> categories) {
    if (_query.trim().isEmpty) return categories;
    final q = _query.trim();
    return categories.where((c) => c.category.contains(q)).toList();
  }

  void _reload() {
    setState(() {
      _future = widget.loadCategories();
      _query = '';
      _searchController.clear();
    });
  }
}
