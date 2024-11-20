import 'package:flutter/material.dart';

import 'User.dart';

class OffersPage extends StatelessWidget {
  final User user;

  const OffersPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offers')),
      body: Center(
        child: Text('Offers for ${user.username}'),
      ),
    );
  }
}
