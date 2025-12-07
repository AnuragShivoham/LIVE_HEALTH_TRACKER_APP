import 'package:flutter/material.dart';

void main() {
  runApp(const LiveTrackerApp());
}

class LiveTrackerApp extends StatelessWidget {
  const LiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Health Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HealthFormScreen(),
    );
  }
}

class HealthFormScreen extends StatefulWidget {
  const HealthFormScreen({super.key});

  @override
  State<HealthFormScreen> createState() => _HealthFormScreenState();
}

class _HealthFormScreenState extends State<HealthFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String fever = 'No';
  String cough = 'No';
  String fatigue = 'No';
  String age = '';
  String tempF = '';

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data Form'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: fever,
                items: ['Yes', 'No']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => fever = v!),
                decoration: const InputDecoration(labelText: 'Fever'),
              ),
              DropdownButtonFormField<String>(
                value: cough,
                items: ['Yes', 'No']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => cough = v!),
                decoration: const InputDecoration(labelText: 'Cough'),
              ),
              DropdownButtonFormField<String>(
                value: fatigue,
                items: ['Yes', 'No']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
                onChanged: (v) => setState(() => fatigue = v!),
                decoration: const InputDecoration(labelText: 'Fatigue'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                onChanged: (v) => age = v,
                validator: (v) => v == null || v.isEmpty ? 'Enter Age' : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Temperature (°F)'),
                onChanged: (v) => tempF = v,
                validator: (v) => v == null || v.isEmpty ? 'Enter temperature' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      final mlFeatures = {
        'Fever': fever,
        'Cough': cough,
        'Fatigue': fatigue,
        'Age': int.tryParse(age) ?? 0,
        'Temperature_F': double.tryParse(tempF) ?? 0.0,
      };

      setState(() {
        result = 'ML JSON: $mlFeatures';
      });

      debugPrint('ML JSON: $mlFeatures');
    }
  },
  child: const Text('Submit'),
),

              
              if (result.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(result, style: const TextStyle(fontSize: 16)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
