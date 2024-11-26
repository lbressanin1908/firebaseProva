import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/fuel_service.dart';

class AddFuelScreen extends StatefulWidget {
  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  final _formKey = GlobalKey<FormState>();
  final FuelService _fuelService = FuelService();

  String? _date;
  double? _liters;
  int? _mileage;

  void _saveFuelEntry() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      try {
        await _fuelService.addFuelEntry(userId, _date!, _liters!, _mileage!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Abastecimento registrado com sucesso!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao registrar abastecimento: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Abastecimento')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Data (dd/mm/yyyy)'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a data.' : null,
                onSaved: (value) => _date = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantidade de Litros'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || double.tryParse(value) == null
                        ? 'Informe uma quantidade válida.'
                        : null,
                onSaved: (value) => _liters = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quilometragem Atual'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || int.tryParse(value) == null
                        ? 'Informe uma quilometragem válida.'
                        : null,
                onSaved: (value) => _mileage = int.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFuelEntry,
                child: Text('Salvar Abastecimento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
