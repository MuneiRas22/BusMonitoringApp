import 'package:flutter/material.dart';

import 'User.dart';

class WalletPage extends StatelessWidget {
  final User user;

  const WalletPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Center(
        child: Text('Wallet details for ${user.username}'),
      ),
    );
  }
}
