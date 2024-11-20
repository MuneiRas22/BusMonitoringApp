import 'package:flutter/material.dart';

import 'User.dart';

class RewardsPage extends StatelessWidget {
  final User user;

  const RewardsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: Center(
        child: Text('Rewards for ${user.username}'),
      ),
    );
  }
}
