import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vehicle/Model/vehicle_model.dart';

class VehicleProvider with ChangeNotifier {
  List<Vehicle> _vehicles = [];

  List<Vehicle> get vehicles => _vehicles;

  void addVehicle(Vehicle vehicle) {
    final vehicleBox = Hive.box<Vehicle>('vehicles');
    vehicleBox.add(vehicle);
    _vehicles = vehicleBox.values.toList();
    notifyListeners();
  }

  void loadVehicles() {
    final vehicleBox = Hive.box<Vehicle>('vehicles');
    _vehicles = vehicleBox.values.toList();
    notifyListeners();
  }
}