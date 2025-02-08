import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle/Model/vehicle_model.dart';
import 'package:vehicle/Model/provider_class.dart';

class AddVehicleScreen extends StatelessWidget {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final yearController = TextEditingController();
    final efficiencyController = TextEditingController();
    final vehicleProvider = Provider.of<VehicleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Vehicle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Vehicle Name'),
            ),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Model Year'),
            ),
            TextField(
              controller: efficiencyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Fuel Efficiency (km/l)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final year = int.tryParse(yearController.text) ?? 0;
                final efficiency = double.tryParse(efficiencyController.text) ?? 0.0;

                if (name.isNotEmpty && year > 0 && efficiency > 0) {
                  vehicleProvider.addVehicle(Vehicle(
                    name: name,
                    modelYear: year,
                    fuelEfficiency: efficiency,
                  ));
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Vehicle'),
            )
          ],
        ),
      ),
    );
  }
}