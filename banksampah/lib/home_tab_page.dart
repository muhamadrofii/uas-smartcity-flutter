import 'package:flutter/material.dart';
import 'api_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edukasi Sampah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeTabPage(),
    );
  }
}

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<Edukasi> _edukasiList = [];
  bool _isLoading = true;
  final ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    _fetchEdukasi();
  }

  void _fetchEdukasi() async {
    try {
      final edukasiList = await apiHelper.fetchEdukasi();
      setState(() {
        _edukasiList = edukasiList;
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil dimuat')),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load edukasi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edukasi Sampah'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _edukasiList.length,
              itemBuilder: (context, index) {
                final edukasi = _edukasiList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edukasi.judul,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        edukasi.ringaksan,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Sumber: ${edukasi.sumber}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
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
