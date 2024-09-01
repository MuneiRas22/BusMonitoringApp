import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'payment_page.dart';

class BusDetailsPage extends StatelessWidget {
  final String fromLocation;
  final String toLocation;

  const BusDetailsPage({
    required this.fromLocation,
    required this.toLocation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data for bus route stops
    final List<Map<String, String>> stops = [
      {'stop': 'Stop 1', 'time': '08:00 AM'},
      {'stop': 'Stop 2', 'time': '08:15 AM'},
      {'stop': 'Stop 3', 'time': '08:30 AM'},
      {'stop': 'Stop 4', 'time': '08:45 AM'},
      {'stop': 'Stop 5', 'time': '09:00 AM'},
    ];

    void _endTripAtStop(String stop) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(
            price: 30.0, // This could be dynamically calculated based on the stop
            stopName: stop,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Route Details'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-34.9285, 138.6007), // Default location
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('start'),
                  position: LatLng(-34.9285, 138.6007), // Example coordinates for "fromLocation"
                  infoWindow: InfoWindow(title: 'From: $fromLocation'),
                ),
                Marker(
                  markerId: MarkerId('end'),
                  position: LatLng(-34.9175, 138.6007), // Example coordinates for "toLocation"
                  infoWindow: InfoWindow(title: 'To: $toLocation'),
                ),
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: stops.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.directions_bus,
                    color: index == stops.length - 1 ? Colors.red : Colors.blue,
                  ),
                  title: Text(stops[index]['stop']!),
                  subtitle: Text('Arrival Time: ${stops[index]['time']}'),
                  trailing: ElevatedButton(
                    onPressed: () => _endTripAtStop(stops[index]['stop']!),
                    child: const Text('End Trip Here'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
