import 'package:flutter/material.dart';
import 'api_helper.dart';

class ScheduleTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SETOR SAMPAH'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BankSampahFormPage(),
      ),
    );
  }
}

class BankSampahFormPage extends StatefulWidget {
  @override
  _BankSampahFormPageState createState() => _BankSampahFormPageState();
}

class _BankSampahFormPageState extends State<BankSampahFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiHelper = ApiHelper();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _jenisSampahController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'nama': _namaController.text,
        'alamat': _alamatController.text,
        'jenis_sampah': _jenisSampahController.text,
        'berat_kg': double.parse(_beratController.text),
        'latitude': double.parse(_latitudeController.text),
        'longitude': double.parse(_longitudeController.text),
      };

      print('Form Data: $data');

      try {
        final response = await _apiHelper.saveBankSampah(data);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Form submitted successfully')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _namaController,
            decoration: InputDecoration(
              labelText: 'Nama',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Nama';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _alamatController,
            decoration: InputDecoration(
              labelText: 'Alamat',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Alamat';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _jenisSampahController,
            decoration: InputDecoration(
              labelText: 'Jenis Sampah',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Jenis Sampah';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _beratController,
            decoration: InputDecoration(
              labelText: 'Berat (kg)',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Berat';
              }
              if (double.tryParse(value) == null) {
                return 'Masukkan angka yang valid';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _latitudeController,
            decoration: InputDecoration(
              labelText: 'Latitude',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Latitude';
              }
              if (double.tryParse(value) == null) {
                return 'Masukkan angka yang valid';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _longitudeController,
            decoration: InputDecoration(
              labelText: 'Longitude',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Longitude';
              }
              if (double.tryParse(value) == null) {
                return 'Masukkan angka yang valid';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton.icon(
              onPressed: _submitForm,
              icon: Icon(Icons.save),
              label: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
