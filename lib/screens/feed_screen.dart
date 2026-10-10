import 'package:flutter/material.dart';

import '../data/tours.dart';
import '../models/tour.dart';
import '../widgets/tour_card.dart';

/// Tab 1: all tours with a category filter.
class FeedScreen extends StatefulWidget {
  final Set<int> favoriteIds;
  final void Function(Tour tour) onOpen;
  final void Function(Tour tour) onToggleFavorite;

  const FeedScreen({
    super.key,
    required this.favoriteIds,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      ...{for (final t in tours) t.category},
    ];
    final visibleTours = tours
        .where(
          (t) => selectedCategory == 'All' || t.category == selectedCategory,
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              for (final category in categories)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (_) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: [
              for (final tour in visibleTours)
                TourCard(
                  tour: tour,
                  isFavorite: widget.favoriteIds.contains(tour.id),
                  onTap: () => widget.onOpen(tour),
                  onFavoriteTap: () => widget.onToggleFavorite(tour),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
