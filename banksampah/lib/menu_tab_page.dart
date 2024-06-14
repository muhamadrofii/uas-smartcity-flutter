import 'package:flutter/material.dart';

import 'demo_mw_tab_bar_screen3.dart';
import 'home_screen.dart';

class MenuTabPage extends StatefulWidget {
  @override
  _MenuTabPageState createState() => _MenuTabPageState();
}

class _MenuTabPageState extends State<MenuTabPage> {
  bool _darkMode = false;

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin logout?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        ExpansionTile(
          leading: Icon(Icons.settings, color: appStore.iconColor),
          title: Text('Pengaturan',
              style: TextStyle(color: appStore.textPrimaryColor)),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        Icon(Icons.account_circle, color: appStore.iconColor),
                    title: Text('Informasi Akun',
                        style: TextStyle(color: appStore.textPrimaryColor)),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.description, color: appStore.iconColor),
                    title: Text('Persyaratan dan Ketentuan',
                        style: TextStyle(color: appStore.textPrimaryColor)),
                    onTap: () {},
                  ),
                  Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.info, color: appStore.iconColor),
                    title: Text('Informasi Versi Aplikasi',
                        style: TextStyle(color: appStore.textPrimaryColor)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help, color: appStore.iconColor),
          title: Text('Layanan',
              style: TextStyle(color: appStore.textPrimaryColor)),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.feedback, color: appStore.iconColor),
          title:
              Text('Aduan', style: TextStyle(color: appStore.textPrimaryColor)),
          onTap: () {},
        ),
        Divider(),
        ExpansionTile(
          leading: Icon(Icons.phone, color: appStore.iconColor),
          title: Text('Call Service',
              style: TextStyle(color: appStore.textPrimaryColor)),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: appStore.iconColor),
                    title: Text('Cs. 083197971346',
                        style: TextStyle(color: appStore.textPrimaryColor)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: appStore.iconColor),
                    title: Text('Cs. 083144853630',
                        style: TextStyle(color: appStore.textPrimaryColor)),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: appStore.iconColor),
          title: Text('Logout',
              style: TextStyle(color: appStore.textPrimaryColor)),
          onTap: _showLogoutDialog,
        ),
      ],
    );
  }
}
