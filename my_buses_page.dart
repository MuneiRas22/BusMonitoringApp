import 'package:flutter/material.dart';
import 'bus_details_page.dart';

class MyBusesPage extends StatelessWidget {
  final String busStop;

  const MyBusesPage({required this.busStop, super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for buses and their details
    final List<Map<String, String>> buses = [
      {'route': 'Bus A', 'stops': '5', 'duration': '15 mins'},
      {'route': 'Bus B', 'stops': '8', 'duration': '20 mins'},
      {'route': 'Bus C', 'stops': '6', 'duration': '18 mins'},
    ];

    void _navigateToBusDetails(String busRoute) {
      // Pass fromLocation and toLocation along with busRoute
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusDetailsPage(
            fromLocation: 'Starting Point', // Replace with actual data
            toLocation: 'Destination Point', // Replace with actual data
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Buses for $busStop'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: buses.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(buses[index]['route']!),
              subtitle: Text(
                '${buses[index]['stops']} stops - ${buses[index]['duration']}',
              ),
              onTap: () => _navigateToBusDetails(buses[index]['route']!),
            );
          },
        ),
      ),
    );
  }
}
