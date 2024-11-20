import 'package:flutter/material.dart';

import 'User.dart';

class HelpSupportPage extends StatelessWidget {
  final User user;

  const HelpSupportPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help and Support')),
      body: Center(
        child: Text('Help and support for ${user.username}'),
      ),
    );
  }
}
