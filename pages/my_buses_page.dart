import 'package:flutter/material.dart';

class MyBusesPage extends StatelessWidget {
  final String busStop;

  const MyBusesPage({Key? key, required this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buses at $busStop'),
      ),
      body: Center(
        child: Text(
          'Displaying buses for $busStop',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
