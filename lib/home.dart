import 'package:christian_sns/botnav/mainfeed.dart';
import 'package:christian_sns/botnav/walkwith.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_final_fields
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // User? user = _auth.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => setState(() {
                _selectedIndex = 0;
              }),
              icon: const Icon(Icons.home),
              color: Colors.black54,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => setState(() {
                _selectedIndex = 1;
              }),
              icon: const Icon(Icons.group),
              color: Colors.black54,
            ),
            label: '동행',
          ),
        ],
      ),
      body: _widgetList.elementAt(_selectedIndex),
    );
  }
}

List<Widget> _widgetList = <Widget>[
  MainFeedPage(),
  WalkWithPage(),
];
