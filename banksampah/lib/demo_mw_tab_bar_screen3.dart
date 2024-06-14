import 'package:flutter/material.dart';
import 'home_tab_page.dart';
import 'maps_tab_page.dart';
import 'schedule_tab_page.dart';
import 'notifications_tab_page.dart';
import 'menu_tab_page.dart';
import 'api_helper.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoMWTabBarScreen3(),
    );
  }
}

class DemoMWTabBarScreen3 extends StatefulWidget {
  static String tag = "/DemoMWTabBarScreen3";

  @override
  _DemoMWTabBarScreen3State createState() => _DemoMWTabBarScreen3State();
}

class _DemoMWTabBarScreen3State extends State<DemoMWTabBarScreen3>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiHelper apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _tabController.addListener(_handleTabSelection);
    _checkToken();
  }

  void _checkToken() async {
    final token = await apiHelper.getToken();
    if (token == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appStore.appBarColor,
          iconTheme: IconThemeData(color: appStore.iconColor),
          title: Text(
            'MENU',
            style: TextStyle(
              color: appStore.textPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {
              print(index);
            },
            indicatorColor: Colors.blue,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: _tabController.index != 0
                      ? appStore.iconSecondaryColor
                      : Colors.blue,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.map,
                  color: _tabController.index != 1
                      ? appStore.iconSecondaryColor
                      : Colors.blue,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.create,
                  color: _tabController.index != 2
                      ? appStore.iconSecondaryColor
                      : Colors.blue,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.history,
                  color: _tabController.index != 3
                      ? appStore.iconSecondaryColor
                      : Colors.blue,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.menu,
                  color: _tabController.index != 4
                      ? appStore.iconSecondaryColor
                      : Colors.blue,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            HomeTabPage(),
            MapsTabPage(),
            ScheduleTabPage(),
            NotificationsTabPage(),
            MenuTabPage(),
          ],
        ),
      ),
    );
  }
}

class AppStore {
  Color? textPrimaryColor;
  Color? iconColorPrimaryDark;
  Color? scaffoldBackground;
  Color? backgroundColor;
  Color? backgroundSecondaryColor;
  Color? appColorPrimaryLightColor;
  Color? textSecondaryColor;
  Color? appBarColor;
  Color? iconColor;
  Color? iconSecondaryColor;
  Color? cardColor;

  AppStore() {
    textPrimaryColor = Color(0xFF212121);
    iconColorPrimaryDark = Color(0xFF212121);
    scaffoldBackground = Color(0xFFEBF2F7);
    backgroundColor = Colors.black;
    backgroundSecondaryColor = Color(0xFF131d25);
    appColorPrimaryLightColor = Color(0xFFF9FAFF);
    textSecondaryColor = Color(0xFF5A5C5E);
    appBarColor = Colors.white;
    iconColor = Color(0xFF212121);
    iconSecondaryColor = Color(0xFFA8ABAD);
    cardColor = Color(0xFF191D36);
  }
}

AppStore appStore = AppStore();
