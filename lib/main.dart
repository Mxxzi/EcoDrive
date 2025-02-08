import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle/Model/vehicle_model.dart';
import 'package:vehicle/Model/provider_class.dart';
import 'package:vehicle/Screens/VehicleListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(VehicleAdapter());
  await Hive.openBox<Vehicle>('vehicles');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VehicleProvider()..loadVehicles(),
      child: MaterialApp(
        title: 'Vehicle List',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const VehicleListScreen(),
      ),
    );
  }
}
