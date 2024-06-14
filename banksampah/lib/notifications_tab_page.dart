import 'package:flutter/material.dart';
import 'api_helper.dart';

class NotificationsTabPage extends StatefulWidget {
  @override
  _NotificationsTabPageState createState() => _NotificationsTabPageState();
}

class _NotificationsTabPageState extends State<NotificationsTabPage> {
  List<History> _historyList = [];
  bool _isLoading = true;
  final ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  void _fetchHistory() async {
    try {
      final historyList = await apiHelper.fetchHistory();
      setState(() {
        _historyList = historyList;
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('History berhasil dimuat')),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load history: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Setor'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _historyList.length,
              itemBuilder: (context, index) {
                final history = _historyList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nama: ${history.nama}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Alamat: ${history.alamat}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Jenis Sampah: ${history.jenis_sampah}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Berat: ${history.berak_kg} kg",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Tanggal: ${history.tanggal}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Email: ${history.email}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Latitude: ${history.latitude}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "Longitude: ${history.longitude}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
