import 'package:flutter/material.dart';

/// Sticky bar at the bottom of the detail screen: price + booking button.
class BookingBar extends StatelessWidget {
  final double price;
  final bool isBooked;
  final VoidCallback onPressed;

  const BookingBar({
    super.key,
    required this.price,
    required this.isBooked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price', style: TextStyle(color: Colors.grey)),
                  Text(
                    '\$${price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Expanded makes the button fill the rest of the bar.
              Expanded(
                child: FilledButton(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: isBooked ? Colors.grey.shade700 : null,
                  ),
                  child: Text(isBooked ? 'Cancel booking' : 'Book now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
