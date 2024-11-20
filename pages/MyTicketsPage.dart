import 'package:flutter/material.dart';

import 'User.dart';

class MyTicketsPage extends StatelessWidget {
  final User user;

  const MyTicketsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tickets')),
      body: Center(
        child: Text('Tickets for ${user.username}'),
      ),
    );
  }
}
