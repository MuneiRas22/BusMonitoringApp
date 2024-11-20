import 'package:flutter/material.dart';

import 'User.dart';

class ReferLearnPage extends StatelessWidget {
  final User user;

  const ReferLearnPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Refer & Learn')),
      body: Center(
        child: Text('Refer and Learn for ${user.username}'),
      ),
    );
  }
}
