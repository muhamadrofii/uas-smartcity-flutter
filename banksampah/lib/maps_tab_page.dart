import 'package:flutter/material.dart';
import 'open_maps.dart';

class MapsTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Maps',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OpenMaps()),
              );
            },
            child: Text('Go to Open Page'),
          ),
        ],
      ),
    );
  }
}
