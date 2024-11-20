import 'package:flutter/material.dart';

import 'User.dart';

class FavoritesPage extends StatelessWidget {
  final User user;

  const FavoritesPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Center(
        child: Text('Favorites for ${user.username}'),
      ),
    );
  }
}
