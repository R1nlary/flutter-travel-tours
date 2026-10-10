import 'package:flutter/material.dart';

/// Tab 4: user info, small statistics and two settings switches.
class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final int favoritesCount;
  final int bookingsCount;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.favoritesCount,
    required this.bookingsCount,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notifications = true;
  bool emailDigest = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        const Center(
          child: CircleAvatar(radius: 48, child: Icon(Icons.person, size: 56)),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            widget.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Center(child: Text(widget.email)),
        const SizedBox(height: 24),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Saved tours'),
          trailing: Text('${widget.favoritesCount}'),
        ),
        ListTile(
          leading: const Icon(Icons.luggage),
          title: const Text('Bookings'),
          trailing: Text('${widget.bookingsCount}'),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('Notifications'),
          value: notifications,
          onChanged: (value) => setState(() => notifications = value),
        ),
        SwitchListTile(
          title: const Text('Weekly email digest'),
          value: emailDigest,
          onChanged: (value) => setState(() => emailDigest = value),
        ),
      ],
    );
  }
}
