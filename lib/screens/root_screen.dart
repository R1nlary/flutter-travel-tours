import 'package:flutter/material.dart';

import '../models/tour.dart';
import 'bookings_screen.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';
import 'feed_screen.dart';
import 'profile_screen.dart';

/// The main screen: four tabs and a BottomNavigationBar.
class RootScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const RootScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  // Shared data lives here, so every tab sees the same favorites/bookings.
  final Set<int> favoriteIds = {};
  final Set<int> bookedIds = {};

  void toggleFavorite(Tour tour) {
    setState(() {
      if (!favoriteIds.remove(tour.id)) favoriteIds.add(tour.id);
    });
  }

  void toggleBooking(Tour tour) {
    setState(() {
      if (!bookedIds.remove(tour.id)) bookedIds.add(tour.id);
    });
  }

  void openDetail(Tour tour) {
    // Navigator.push opens the DetailScreen and passes the whole object.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          tour: tour,
          isFavorite: favoriteIds.contains(tour.id),
          isBooked: bookedIds.contains(tour.id),
          onToggleFavorite: toggleFavorite,
          onToggleBooking: toggleBooking,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const titles = ['Explore tours', 'Favorites', 'My bookings', 'Profile'];

    return Scaffold(
      appBar: AppBar(title: Text(titles[currentIndex])),
      // IndexedStack keeps every tab alive, so scroll position and
      // switches are not reset when you change the tab.
      body: IndexedStack(
        index: currentIndex,
        children: [
          FeedScreen(
            favoriteIds: favoriteIds,
            onOpen: openDetail,
            onToggleFavorite: toggleFavorite,
          ),
          FavoritesScreen(
            favoriteIds: favoriteIds,
            onOpen: openDetail,
            onToggleFavorite: toggleFavorite,
          ),
          BookingsScreen(
            bookedIds: bookedIds,
            onOpen: openDetail,
            onCancel: toggleBooking,
          ),
          ProfileScreen(
            name: widget.userName,
            email: widget.userEmail,
            favoritesCount: favoriteIds.length,
            bookingsCount: bookedIds.length,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => setState(() => currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.luggage), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
