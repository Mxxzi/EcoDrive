import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle/Model/vehicle_model.dart';
import 'package:vehicle/Model/provider_class.dart';
import 'package:vehicle/Screens/AddVehicleScreen.dart';

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  Color getVehicleColor(Vehicle vehicle) {
    int currentYear = DateTime.now().year;
    int age = (currentYear - vehicle.modelYear) as int;

    if (vehicle.fuelEfficiency >= 15) {
      return age <= 5 ? Colors.green : Colors.amber;
    }
    return Colors.red;
  }

  int getColorPriority(Color color) {
    if (color == Colors.green) return 0;
    if (color == Colors.amber) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    List<Vehicle> sortedVehicles = List.from(vehicleProvider.vehicles);
    sortedVehicles.sort((a, b) {
      Color colorA = getVehicleColor(a);
      Color colorB = getVehicleColor(b);
      return getColorPriority(colorA).compareTo(getColorPriority(colorB));
    });
    log('vehicleProvider ${vehicleProvider.vehicles}');
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Vehicle List',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
      )),
      body: ListView.builder(
        itemCount: sortedVehicles.length,
        itemBuilder: (context, index) {
          final vehicle = sortedVehicles[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: getVehicleColor(vehicle),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: getVehicleColor(vehicle),
                  title: Text(
                    vehicle.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    'Year: ${vehicle.modelYear} | Efficiency: ${vehicle.fuelEfficiency} km/l',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddVehicleScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
