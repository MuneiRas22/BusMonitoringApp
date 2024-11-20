import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Import the LatLng type
import 'package:modernlogintute/pages/payment_page.dart';

class BusDetailsPage extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  final LatLng fromCoordinates; // Add fromCoordinates
  final LatLng toCoordinates; // Add toCoordinates

  const BusDetailsPage({
    required this.fromLocation,
    required this.toLocation,
    required this.fromCoordinates, // Update constructor
    required this.toCoordinates, // Update constructor
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, double> stopPrices = {
      'Stop 1': 10.0,
      'Stop 2': 15.0,
      'Stop 3': 20.0,
      'Stop 4': 25.0,
      'Stop 5': 30.0,
    };

    final List<Map<String, String>> stops = [
      {'stop': 'Stop 1', 'time': '08:00 AM'},
      {'stop': 'Stop 2', 'time': '08:15 AM'},
      {'stop': 'Stop 3', 'time': '08:30 AM'},
      {'stop': 'Stop 4', 'time': '08:45 AM'},
      {'stop': 'Stop 5', 'time': '09:00 AM'},
    ];

    void endTripAtStop(String stop) {
      if (stopPrices.containsKey(stop)) {
        double price = stopPrices[stop]!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(
              price: price,
              stopName: stop,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Price for this stop is not available.')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Route Details'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Map display showing from and to locations
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(
                  (fromCoordinates.latitude + toCoordinates.latitude) / 2,
                  (fromCoordinates.longitude + toCoordinates.longitude) / 2,
                ),
                zoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: fromCoordinates,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 40.0,
                      ),
                    ),
                    Marker(
                      point: toCoordinates,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ],
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
                    onPressed: () => endTripAtStop(stops[index]['stop']!),
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