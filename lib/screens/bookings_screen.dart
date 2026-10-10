import 'package:flutter/material.dart';

import '../data/tours.dart';
import '../models/tour.dart';

/// Tab 3: the booked tours and the total price.
class BookingsScreen extends StatelessWidget {
  final Set<int> bookedIds;
  final void Function(Tour tour) onOpen;
  final void Function(Tour tour) onCancel;

  const BookingsScreen({
    super.key,
    required this.bookedIds,
    required this.onOpen,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final booked = tours.where((t) => bookedIds.contains(t.id)).toList();

    if (booked.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No bookings yet.\nOpen a tour and press "Book now".',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    final total = booked.fold<double>(0, (sum, t) => sum + t.price);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final tour in booked)
                Card(
                  child: ListTile(
                    onTap: () => onOpen(tour),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        tour.image,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(tour.title),
                    subtitle: Text(
                      '${tour.days} days • \$${tour.price.toStringAsFixed(0)}',
                    ),
                    trailing: IconButton(
                      onPressed: () => onCancel(tour),
                      icon: const Icon(Icons.close),
                      tooltip: 'Cancel booking',
                    ),
                  ),
                ),
            ],
          ),
        ),
        Material(
          elevation: 8,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 18)),
                  Text(
                    '\$${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
