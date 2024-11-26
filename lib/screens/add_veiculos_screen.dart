import 'package:flutter/material.dart';
import '../services/veiculo_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nome;
  String? _modelo;
  String? _ano;
  String? _placa;

  final _vehicleService = VehicleService();

  void _saveVehicle() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userId = FirebaseAuth.instance.currentUser!.uid;

      try {
        await _vehicleService.addVehicle(
            userId, _nome!, _modelo!, _ano!, _placa!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veículo adicionado com sucesso!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao adicionar veículo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Veículo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome do Veículo'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe o nome do veículo.'
                    : null,
                onSaved: (value) => _nome = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o modelo.' : null,
                onSaved: (value) => _modelo = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ano'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o ano.' : null,
                onSaved: (value) => _ano = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Placa'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a placa.' : null,
                onSaved: (value) => _placa = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveVehicle,
                child: Text('Salvar Veículo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
