import 'package:flutter/material.dart';

import 'User.dart';

class PaymentHistoryPage extends StatelessWidget {
  final User user;

  const PaymentHistoryPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment History')),
      body: Center(
        child: Text('Payment history for ${user.username}'),
      ),
    );
  }
}
