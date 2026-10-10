import 'package:flutter/material.dart';

import '../data/tours.dart';
import '../models/tour.dart';
import '../widgets/tour_card.dart';

/// Tab 2: the tours the user has saved.
class FavoritesScreen extends StatelessWidget {
  final Set<int> favoriteIds;
  final void Function(Tour tour) onOpen;
  final void Function(Tour tour) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favoriteIds,
    required this.onOpen,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favorites = tours.where((t) => favoriteIds.contains(t.id)).toList();

    if (favorites.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No favorites yet.\nTap the heart on a tour to save it.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final tour in favorites)
          TourCard(
            tour: tour,
            isFavorite: true,
            onTap: () => onOpen(tour),
            onFavoriteTap: () => onToggleFavorite(tour),
          ),
      ],
    );
  }
}
