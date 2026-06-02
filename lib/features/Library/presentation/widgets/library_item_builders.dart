import 'package:flutter/material.dart';

import '../../data/models/category_model.dart';

Widget buildLibraryTextItem(BuildContext context, CategoryItem item) {
  return Text(
    item.text,
    style: const TextStyle(fontSize: 18, height: 1.6),
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.right,
  );
}

Widget buildLibraryHadithItem(BuildContext context, CategoryItem item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        item.text,
        style: const TextStyle(fontSize: 18, height: 1.6),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
      if (item.source != null && item.source!.isNotEmpty) ...[
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.format_quote_rounded,
              size: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                item.source!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
      if (item.description != null && item.description!.isNotEmpty) ...[
        const SizedBox(height: 8),
        Text(
          item.description!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 14,
            height: 1.4,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
      ],
    ],
  );
}

Widget buildLibrarySeerahItem(BuildContext context, CategoryItem item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (item.title != null && item.title!.isNotEmpty) ...[
        Text(
          item.title!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.4,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 10),
      ],
      Text(
        item.text,
        style: const TextStyle(fontSize: 18, height: 1.6),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
      if (item.description != null && item.description!.isNotEmpty) ...[
        const SizedBox(height: 8),
        Text(
          item.description!,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 14,
            height: 1.4,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
      ],
    ],
  );
}

Widget buildLibraryAzkarItem(BuildContext context, CategoryItem item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        item.text,
        style: const TextStyle(fontSize: 18, height: 1.6),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
      if (item.count > 1) ...[
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'عدد المرات: ${item.count}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ],
  );
}
