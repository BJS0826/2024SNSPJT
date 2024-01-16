import 'package:flutter/material.dart';
import 'package:christian_sns/botnav/boardpost.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 17.0),
            child: const Text('헤브넷'),
          ),
          leading: Container(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // 검색 버튼 동작
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // 하트 버튼 동작
              },
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                // 메시지 버튼 동작
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // 글 유형 별 탭 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(child: Text("전체"), onPressed: () {}),
                ElevatedButton(child: Text("중보기도"), onPressed: () {}),
                ElevatedButton(child: Text("자유"), onPressed: () {}),
                ElevatedButton(child: Text("기타"), onPressed: () {}),
              ],
            ),

            // 글 목록
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  title: Text("글 제목1"),
                ),
                ListTile(
                  title: Text("글 제목2"),
                )
              ],
            )),

            // 글쓰기 버튼
            ElevatedButton(
                child: Text("글쓰기"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BoardPostPage()),
                  );
                }),
          ],
        ));
  }
}
