import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prova/screens/add_fuel_screen.dart';
import 'package:prova/screens/add_veiculos_screen.dart';
import 'package:prova/screens/edit_vehicle_screen.dart';
import 'package:prova/screens/home_screen.dart';
import 'package:prova/screens/veiculos_screen.dart';
import 'package:prova/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/meus-veiculos': (context) => VehicleScreen(),
        '/adicionar-veiculo': (context) => AddVehicleScreen(),
        '/editar-veiculo': (context) => EditVehicleScreen(
            vehicleId: ModalRoute.of(context)!.settings.arguments as String),
        '/adicionar-combustivel': (context) => AddFuelScreen(),
      },
    );
  }
}
