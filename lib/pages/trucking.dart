import 'package:flutter/material.dart';

class TRUCKING extends StatelessWidget {
  // Placeholder for truck data - in a real app, this would come from a database or API
  final List<Map<String, dynamic>> trucks = [
    {"name": "Truck A", "status": "En route"},
    {"name": "Truck B", "status": "Loading"},
    {"name": "Truck C", "status": "Maintenance"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truck Management'),
      ),
      body: ListView.builder(
        itemCount: trucks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text(trucks[index]["name"]),
              subtitle: Text('Status: ${trucks[index]["status"]}'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Placeholder for action, e.g., navigating to a detailed view
              },
            ),
          );
        },
      ),
    );
  }
}
