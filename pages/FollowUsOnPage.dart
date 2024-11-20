import 'package:flutter/material.dart';

import 'User.dart';

class FollowUsOnPage extends StatelessWidget {
  final User user;

  const FollowUsOnPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Follow Us On')),
      body: Center(
        child: Text('Follow us on social platforms for ${user.username}'),
      ),
    );
  }
}
