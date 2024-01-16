import 'package:flutter/material.dart';

class BoardPostPage extends StatefulWidget {
  @override
  _BoardPostPageState createState() => _BoardPostPageState();
}

class _BoardPostPageState extends State<BoardPostPage> {
  String _selectedCategory = "전체";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("글쓰기"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // 카테고리 선택
            DropdownButton<String>(
              value: _selectedCategory,
              items: [
                DropdownMenuItem<String>(
                  child: Text("전체"),
                  value: "전체",
                ),
                DropdownMenuItem<String>(
                  child: Text("중보기도"),
                  value: "중보기도",
                ),
                // 다른 카테고리 아이템 추가
              ],
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),

            // 제목 TextField
            TextField(
              decoration: InputDecoration(
                labelText: "제목",
              ),
            ),

            // 내용 TextField
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "내용",
              ),
            ),

            // 이미지 첨부 버튼
            ElevatedButton(
              child: Text("이미지 첨부"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
