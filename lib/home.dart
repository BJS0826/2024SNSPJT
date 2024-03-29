import 'package:christian_sns/botnav/createfeed.dart';
import 'package:christian_sns/botnav/mainfeed.dart';
import 'package:christian_sns/botnav/profile.dart';
import 'package:christian_sns/botnav/walkwith.dart';
import 'package:christian_sns/botnav/board.dart';
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
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => setState(() {
                _selectedIndex = 2;
              }),
              icon: const Icon(Icons.add_box),
              color: Colors.black54,
            ),
            label: '작성',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => setState(() {
                _selectedIndex = 3;
              }),
              icon: const Icon(Icons.add_box),
              color: Colors.black54,
            ),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () => setState(() {
                _selectedIndex = 4;
              }),
              icon: const Icon(Icons.add_box),
              color: Colors.black54,
            ),
            label: '프로필',
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
  CreateFeedPage(),
  BoardPage(),
  ProfilePage(),
];
