import 'package:flutter/material.dart';

import '../models/tour.dart';
import '../widgets/booking_bar.dart';

/// Shows one tour. The tour object arrives through the constructor.
class DetailScreen extends StatefulWidget {
  final Tour tour;
  final bool isFavorite;
  final bool isBooked;
  final void Function(Tour tour) onToggleFavorite;
  final void Function(Tour tour) onToggleBooking;

  const DetailScreen({
    super.key,
    required this.tour,
    required this.isFavorite,
    required this.isBooked,
    required this.onToggleFavorite,
    required this.onToggleBooking,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool isFavorite = widget.isFavorite;
  late bool isBooked = widget.isBooked;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onToggleFavorite(widget.tour);
  }

  void toggleBooking() {
    setState(() {
      isBooked = !isBooked;
    });
    widget.onToggleBooking(widget.tour);

    final message = isBooked ? 'Tour booked!' : 'Booking cancelled';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tour = widget.tour;

    return Scaffold(
      appBar: AppBar(title: const Text('Tour details')),
      body: Center(
        // On large screens the content keeps a readable width.
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildBanner(tour),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: buildInfo(tour),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BookingBar(
        price: tour.price,
        isBooked: isBooked,
        onPressed: toggleBooking,
      ),
    );
  }

  /// Image with a dark gradient, the title on top of it and a heart (Stack).
  Widget buildBanner(Tour tour) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(tour.image, fit: BoxFit.cover),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tour.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  tour.location,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: toggleFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Rating, duration, tags (Wrap) and description.
  Widget buildInfo(Tour tour) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 4,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(' ${tour.rating}'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.schedule, size: 20),
                Text(' ${tour.days} days'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.category, size: 20),
                Text(' ${tour.category}'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final tag in tour.tags) Chip(label: Text(tag))],
        ),
        const SizedBox(height: 16),
        const Text(
          'About this tour',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(tour.description, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
