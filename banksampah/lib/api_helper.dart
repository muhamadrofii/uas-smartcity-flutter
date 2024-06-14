import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Edukasi {
  final int id;
  final String judul;
  final String ringaksan;
  final String sumber;

  Edukasi({
    required this.id,
    required this.judul,
    required this.ringaksan,
    required this.sumber,
  });

  factory Edukasi.fromJson(Map<String, dynamic> json) {
    return Edukasi(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      ringaksan: json['ringaksan'] ?? '',
      sumber: json['sumber'] ?? '',
    );
  }
}

class History {
  final int id;
  final String nama;
  final String alamat;
  final String jenis_sampah;
  final String tanggal;
  final double berak_kg;
  final String email;
  final double latitude;
  final double longitude;

  History({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.jenis_sampah,
    required this.tanggal,
    required this.berak_kg,
    required this.email,
    required this.latitude,
    required this.longitude,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      jenis_sampah: json['jenis_sampah'] ?? '',
      tanggal: json['tanggal'] ?? '',
      berak_kg: json['berak_kg'] != null
          ? (json['berak_kg'] is double
              ? json['berak_kg']
              : double.tryParse(json['berak_kg'].toString()) ?? 0.0)
          : 0.0,
      email: json['email'] ?? '',
      latitude: json['latitude'] != null
          ? (json['latitude'] is double
              ? json['latitude']
              : double.tryParse(json['latitude'].toString()) ?? 0.0)
          : 0.0,
      longitude: json['longitude'] != null
          ? (json['longitude'] is double
              ? json['longitude']
              : double.tryParse(json['longitude'].toString()) ?? 0.0)
          : 0.0,
    );
  }
}

class ApiHelper {
  final String baseUrl = "http://192.168.1.8:3000/users";
  final int tokenExpiryDuration = 3600;

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime now = DateTime.now();
    final String expiryDate =
        now.add(Duration(seconds: tokenExpiryDuration)).toIso8601String();
    await prefs.setString('jwt_token', token);
    await prefs.setString('jwt_token_expiry', expiryDate);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt_token');
    final String? expiryDateStr = prefs.getString('jwt_token_expiry');

    if (token != null && expiryDateStr != null) {
      final DateTime expiryDate = DateTime.parse(expiryDateStr);
      if (DateTime.now().isBefore(expiryDate)) {
        return token;
      } else {
        await prefs.remove('jwt_token');
        await prefs.remove('jwt_token_expiry');
      }
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final String token = responseData['token'];
      await saveToken(token);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Edukasi>> fetchEdukasi() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token is not available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/edukasi'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Data received: $data');
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        var edukasiList = data['data'] as List;
        return edukasiList.map((item) => Edukasi.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load edukasi');
    }
  }

  Future<List<History>> fetchHistory() async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token is not available');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/history'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Data received: $data');
      if (data is List) {
        return data.map((item) => History.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } else {
      print('Error fetching history: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load history');
    }
  }

  Future<http.Response> saveBankSampah(Map<String, dynamic> data) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('Token is not available');
    }

    final url = Uri.parse('$baseUrl/posting'); // Endpoint for posting
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode(data);

    print('Request URL: $url');
    print('Request Headers: $headers');
    print('Request Body: $body');

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // Debug log for response
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    return response;
  }
}
